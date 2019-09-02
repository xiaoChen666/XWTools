//
//  XWRegisterSetPasswordViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWRegisterSetPasswordViewController.h"
#import "XWFillMessageViewController.h"
#import "XWSendMsgBtn.h"
#import "CXWBaseNavigationController.h"
#import "UITextField+CXWTF.h"
#import "XWTabbarController.h"

@interface XWRegisterSetPasswordViewController ()
@property (nonatomic, strong) XWSendMsgBtn *yanzhengBtn;

@property (nonatomic, strong) XWInputTF *passwordTF;
@property (nonatomic, strong) XWInputTF *yanzhengTF;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger jishi;
@end

@implementation XWRegisterSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_netWork];
    
    
    [self.passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.yanzhengTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField==self.passwordTF) {
        [[CXWDataManager shareManager] XWLimitTextFieldLengthWithTextFiled:textField AndMaxLength:12];
    }else {
        [[CXWDataManager shareManager] XWLimitTextFieldLengthWithTextFiled:textField AndMaxLength:8];
    }
}

#pragma mark  ======Event======
- (void)registerBtnClick:(UIButton *)sender {

    
}

- (void)yanzhengBtnClick:(UIButton *)sender {
    [self xw_netWork];
}

- (void)secretBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.passwordTF CXWSetSecureEntry:!sender.selected];
}


- (void)xw_netWork {
    
}

- (void)CXWChuLiData:(CXWNetPublicModel *)NetModel {
    
    self.yanzhengBtn.userInteractionEnabled = NO;
    [[CXWAlertTools shareTools] CXWAlertTrueMessageWithTitle:NetModel.message];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[YYWeakProxy proxyWithTarget:self] selector:@selector(timerFired) userInfo:nil repeats:YES];
    _jishi = 60;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerFired {
    _jishi-=1;
    [self.yanzhengBtn setTitle:[NSString stringWithFormat:@"重发(%zd秒)",_jishi] forState:UIControlStateNormal];
    
    if (_jishi==0) {
        [_timer invalidate];
        [self.yanzhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.yanzhengBtn.userInteractionEnabled=YES;
        _jishi=60;
    }
}



#pragma mark  ======UI======
- (void)CXWAddSubviews {
    [super CXWAddSubviews];
    
    UILabel *titleLabel = [self publicLabel];
    titleLabel.text = @"请输入\n验证码注册";
    
    CXWPublicSeparatorView *leftLineView = [self publicLineView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:12];
    contentLabel.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    contentLabel.numberOfLines = 0;
    contentLabel.text = [NSString stringWithFormat:@"验证码已发送\n手机尾号为%@的用户",[self.phoneNumber substringFromIndex:7]];

    
    XWSendMsgBtn *yanzhengBtn = [XWSendMsgBtn buttonWithType:UIButtonTypeCustom];
    [yanzhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzhengBtn setTitleColor:[UIColor colorWithHexString:CXWWriteColorStr] forState:UIControlStateNormal];
    yanzhengBtn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:9];
    yanzhengBtn.layer.cornerRadius = 8;
    yanzhengBtn.layer.borderWidth = 1;
    yanzhengBtn.layer.borderColor = [UIColor colorWithHexString:CXWWriteColorStr].CGColor;
    [yanzhengBtn addTarget:self action:@selector(yanzhengBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.yanzhengBtn = yanzhengBtn;
    
    XWInputTF *passwordTF = [self publicInputTF];
    passwordTF.placeholder = @"请设置密码";
    passwordTF.secureTextEntry = YES;
    self.passwordTF = passwordTF;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);  //openpassword_icon  closepassword_icon
    [rightBtn setImage:[UIImage imageNamed:@"closepassword_icon"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"openpassword_icon"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(secretBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    passwordTF.rightView = rightBtn;
    passwordTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    CXWPublicSeparatorView *passwordLineView = [self publicLineView];
    
    
    XWInputTF *yanzhengTF = [self publicInputTF];
    yanzhengTF.placeholder = @"请输入验证码";
    yanzhengTF.keyboardType = UIKeyboardTypeNumberPad;
    self.yanzhengTF = yanzhengTF;
    
    CXWPublicSeparatorView *yanzhengLineView = [self publicLineView];
    
    UIButton *registerBtn = [self publicSureBtn];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:leftLineView];
    [self.view addSubview:contentLabel];
    [self.view addSubview:yanzhengBtn];
    [self.view addSubview:passwordTF];
    [self.view addSubview:passwordLineView];
    [self.view addSubview:yanzhengTF];
    [self.view addSubview:yanzhengLineView];
    [self.view addSubview:registerBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_NAVBAR_HEIGHT+12);
    }];
    
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.bottom.equalTo(contentLabel);
        make.width.mas_equalTo(1);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).with.offset(5);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(20);
    }];
    
    [yanzhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-43);
        make.centerY.equalTo(contentLabel);
    }];
    

    
    [yanzhengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.right.equalTo(self.view).with.offset(-46);
        make.height.mas_equalTo(30);
        make.top.equalTo(contentLabel.mas_bottom).with.offset(60);
    }];
    
    [yanzhengLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(yanzhengTF);
        make.height.mas_equalTo(1);
        make.top.equalTo(yanzhengTF.mas_bottom).with.offset(1);
    }];
    
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(yanzhengTF);
        make.top.equalTo(yanzhengLineView.mas_bottom).with.offset(25);
    }];
    
    [passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(yanzhengLineView);
        make.top.equalTo(passwordTF.mas_bottom).with.offset(1);
    }];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.centerX.equalTo(self.view);
        make.top.equalTo(passwordLineView.mas_bottom).with.offset(58);
    }];
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
