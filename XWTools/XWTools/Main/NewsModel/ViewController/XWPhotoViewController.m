//
//  XWPhotoViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/11/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWPhotoViewController.h"
#import "TOCropViewController.h"
#import "UINavigationController+CXWCustomBar.h"
#import "UIAlertController+CXWAlertVC.h"
@interface XWPhotoViewController ()<TOCropViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImagePickerController *imagePicker; //获取图片
@end

@implementation XWPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self photoAlertAction];
}



#pragma mark  ======调用相机======

- (void)photoAlertAction {
    _imagePicker = [[UIImagePickerController alloc]init];
    _imagePicker.delegate = self;
    
    if ([_imagePicker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [_imagePicker CXWSetCustomBar];
    }

    XMWeakSelf;
    UIAlertController *alertController = [UIAlertController CXWAlertWithTitle:@"更改个人头像" AndVCStyle:UIAlertControllerStyleActionSheet AndFirstTitle:@"拍照" AndFirstBlock:^{
        [weakSelf CXWAlertCamera];
    } AndSecondTitle:@"从照片库选取" AndSecondBlock:^{
        [weakSelf CXWAlertPhotoAlums];
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
//    [self CXWChangeAvatar:image];
    [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:cropRect completion:nil];
}

@end
