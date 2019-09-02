//
//  XWFillMessageViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWFillMessageViewController.h"

#import "UIButton+ImageTitleSpacing.h"

#import "UINavigationController+CXWCustomBar.h"
#import "TOCropViewController.h"
#import "UIAlertController+CXWAlertVC.h"

#import "XWTabbarController.h"

@interface XWFillMessageViewController ()<TOCropViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIButton *avatarBtn;

@property (nonatomic, strong) UIImage *avtarIMG;
@property (nonatomic, strong) XWInputTF *nickTF;

@property (nonatomic,strong) UIImagePickerController *imagePicker; //获取图片
@end

@implementation XWFillMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nickTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)textFieldDidChange:(UITextField *)sender {
    [[CXWDataManager shareManager] XWLimitTextFieldLengthWithTextFiled:sender AndMaxLength:10];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden: YES animated: animated];
}


#pragma mark  ======Event======

- (void)sexBtnClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    self.tempBtn.selected = NO;
    self.tempBtn = sender;
    
}

- (void)avtarBtnClick {
    [self photoAlertAction];
}


- (void)completeBtnClick:(UIButton *)sender {
}

#pragma mark  ======照片选择======
- (void)photoAlertAction {
    _imagePicker = [[UIImagePickerController alloc]init];
    _imagePicker.delegate = self;
    
    if ([_imagePicker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [_imagePicker CXWSetCustomBar];
    }
    @weakify(self);
    UIAlertController *alertController = [UIAlertController CXWAlertWithTitle:@"更改个人头像" AndVCStyle:UIAlertControllerStyleActionSheet AndFirstTitle:@"拍照" AndFirstBlock:^{
        [weak_self CXWAlertCamera];
    } AndSecondTitle:@"从照片库选取" AndSecondBlock:^{
        [weak_self CXWAlertPhotoAlums];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - 弹出框代理事件

- (void)CXWAlertCamera
{
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if ([[CXWDataManager shareManager] isCanUsePhotos]) {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }
        else {
            [[CXWDataManager shareManager] CXWCannotUserPhotoAlertMessage];
        }
    }
    else {
        [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:@"您的手机不支持相机"];
    }
}

- (void)CXWAlertPhotoAlums
{
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}
// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:info[UIImagePickerControllerOriginalImage]];
    cropController.delegate = self;
    cropController.cropStyle = CXWCropPhotoStyleSquare;
    [picker pushViewController:cropController animated:YES];
    
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {

    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    self.avtarIMG = image;
    [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:cropRect completion:nil];
}


#pragma mark  ======UI======
- (void)CXWAddSubviews {
    [super CXWAddSubviews];
    
    UIButton *avatarBtn= [[UIButton alloc] init];
    avatarBtn.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    avatarBtn.layer.cornerRadius = 57.5;
    avatarBtn.layer.masksToBounds = YES;
    avatarBtn.layer.borderWidth = 2;
    avatarBtn.layer.borderColor = [UIColor colorWithHexString:CXWWriteColorStr].CGColor;
    [avatarBtn setImage:[UIImage imageNamed:@"camera_icon"] forState:UIControlStateNormal];
    [avatarBtn addTarget:self action:@selector(avtarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.avatarBtn = avatarBtn;
    
    UILabel *avatarLabel = [[UILabel alloc] init];
    avatarLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:19];
    avatarLabel.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    avatarLabel.text = @"头像";
    
    
    UILabel *sexLabel = [[UILabel alloc] init];
    sexLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:17];
    sexLabel.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    sexLabel.text = @"性别";
    
    UIButton *manBtn = [self backBtnWithNormalImage:[UIImage imageNamed:@"man_unselect"] SelectImage:[UIImage imageNamed:@"man_select"] AndTitle:@"男"];
    
    UIButton *womanBtn = [self backBtnWithNormalImage:[UIImage imageNamed:@"woman_unselect"] SelectImage:[UIImage imageNamed:@"woman_select"] AndTitle:@"女"];
    
    manBtn.tag = 1;
    womanBtn.tag = 0;
    

    
    
    XWInputTF *nameTF = [self publicInputTF];
    nameTF.placeholder = @"用户名";
    nameTF.textAlignment = NSTextAlignmentCenter;
    self.nickTF = nameTF;
    
    CXWPublicSeparatorView *lineView = [[CXWPublicSeparatorView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    
    UIButton *completeBtn = [self publicSureBtn];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:avatarBtn];
    [self.view addSubview:avatarLabel];
    [self.view addSubview:sexLabel];
    [self.view addSubview:manBtn];
    [self.view addSubview:womanBtn];
    [self.view addSubview:nameTF];
    [self.view addSubview:lineView];
    [self.view addSubview:completeBtn];
    
    
    [avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 115));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_NAVBAR_HEIGHT+22);
    }];
    
    
    [avatarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(avatarBtn.mas_bottom).with.offset(10);
    }];
   
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(manBtn.mas_left);
        make.top.equalTo(avatarLabel.mas_bottom).with.offset(15);
    }];
    
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avatarBtn.mas_left);
        make.top.equalTo(sexLabel.mas_bottom).with.offset(15);
    }];
    
    [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avatarBtn.mas_right);
        make.centerY.equalTo(manBtn);
    }];
    
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(avatarLabel.mas_bottom).with.offset(150);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(nameTF);
        make.height.mas_equalTo(1);
        make.top.equalTo(nameTF.mas_bottom).with.offset(1);
    }];
    
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.centerX.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom).with.offset(50);
    }];
    
    
    [manBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [womanBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    
}

- (UIButton *)backBtnWithNormalImage:(UIImage *)normalImage SelectImage:(UIImage *)selectImage AndTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor colorWithHexString:CXWWriteColorStr] forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor colorWithHexString:CXWWriteColorStr] colorWithAlphaComponent:0.5] forState:UIControlStateSelected];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:17];
    [btn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
