//
//  XWLoginViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWLoginViewController.h"

#import "XWRegisterSetPhoneViewController.h"
#import "UITextField+CXWTF.h"

#import "XWFillMessageViewController.h"
#import "XWTabbarController.h"

@interface XWLoginViewController ()
///是否是账号密码登录
@property (nonatomic, assign)BOOL isPasswordVC;
@property (nonatomic,strong) XWInputTF *phoneTF;
@property (nonatomic, strong) XWInputTF *passwordTF;
@property (nonatomic, strong) UIButton *forgetPasswordBtn;

@property (nonatomic, strong) UIButton *secretBtn;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger jishi;

@end

@implementation XWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPasswordVC = YES;

    
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}


- (void)textFieldDidChange:(UITextField *)sender {
    if (sender==self.phoneTF) {
        [[CXWDataManager shareManager] XWLimitTextFieldLengthWithTextFiled:sender AndMaxLength:12];
    }else {
        [[CXWDataManager shareManager] XWLimitTextFieldLengthWithTextFiled:sender AndMaxLength:14];
    }
}

#pragma mark  ======Event======

- (void)registerBtnClick {
    
    for (UIViewController *VC in self.navigationController.childViewControllers) {
        if ([VC isKindOfClass:[XWRegisterSetPhoneViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
            return;
        }
    }
    XWRegisterSetPhoneViewController *VC = [[XWRegisterSetPhoneViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)sureBtnClick:(UIButton *)sender {
    
    
}


- (void)statusBtnClick:(UIButton *)sender {
    self.isPasswordVC = !self.isPasswordVC;
    self.passwordTF.text = nil;
    [self.passwordTF endEditing:YES];
//    [self.passwordTF becomeFirstResponder];
    if (self.isPasswordVC) {
        [sender setTitle:@"手机验证码登录" forState:UIControlStateNormal];
        [self.forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        self.passwordTF.placeholder = @"请输入登录密码";
        self.passwordTF.keyboardType = UIKeyboardTypeDefault;
        self.passwordTF.secureTextEntry = !self.secretBtn.selected;
        self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    } else {
        [sender setTitle:@"密码登录" forState:UIControlStateNormal];
        [self.forgetPasswordBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.passwordTF.placeholder = @"请输入验证码";
        self.passwordTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwordTF.secureTextEntry = NO;
        self.passwordTF.rightViewMode = UITextFieldViewModeNever;
    }
    
    [_timer invalidate];
    self.forgetPasswordBtn.userInteractionEnabled = YES;
}

- (void)secretBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.passwordTF CXWSetSecureEntry:!sender.selected];
}


- (void)forgetPasswordBtnClick:(UIButton *)sender {

}

- (void)CXWChuLiData:(CXWNetPublicModel *)NetModel {
    
    self.forgetPasswordBtn.userInteractionEnabled = NO;
    [[CXWAlertTools shareTools] CXWAlertTrueMessageWithTitle:NetModel.message];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[YYWeakProxy proxyWithTarget:self] selector:@selector(timerFired) userInfo:nil repeats:YES];
    _jishi = 60;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerFired {
    _jishi-=1;
    [self.forgetPasswordBtn setTitle:[NSString stringWithFormat:@"%zd秒后重发",_jishi] forState:UIControlStateNormal];
    
    if (_jishi==0) {
        [_timer invalidate];
        [self.forgetPasswordBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.forgetPasswordBtn.userInteractionEnabled=YES;
        _jishi=60;
    }
}


#pragma mark  ======UI======

- (void)CXWAddNaviSubviews {
    UIButton *rightBtn = [self publicTopBtn];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-25);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_STATUSHEIGHT+23);
    }];
}

- (void)CXWAddSubviews {
    [super CXWAddSubviews];
    
    
    UILabel *titleLabel = [self publicLabel];
    titleLabel.text = @"登录\n欢迎使用测评";
    
    XWInputTF *phoneTF = [self publicInputTF];
    phoneTF.placeholder = @"请输入手机号码";
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    CXWPublicSeparatorView *phoneLineView = [self publicLineView];
    
    
    XWInputTF *passwordTF = [self publicInputTF];
    passwordTF.placeholder = @"请输入登录密码";
    passwordTF.secureTextEntry = YES;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);  //openpassword_icon  closepassword_icon
    [rightBtn setImage:[UIImage imageNamed:@"closepassword_icon"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"openpassword_icon"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(secretBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    passwordTF.rightView = rightBtn;
    passwordTF.rightViewMode = UITextFieldViewModeAlways;
    self.secretBtn = rightBtn;
    

    
    
    CXWPublicSeparatorView *passwordLineView = [self publicLineView];
    
    UIButton *statusBtn = [self publicStatusBtn];
    [statusBtn setTitle:@"手机验证码登录" forState:UIControlStateNormal];
    [statusBtn addTarget:self action:@selector(statusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *forgetPasswordBtn = [self publicStatusBtn];
    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sureBtn = [self publicSureBtn];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.phoneTF = phoneTF;
    self.passwordTF = passwordTF;
    self.forgetPasswordBtn = forgetPasswordBtn;
    
    
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:phoneTF];
    [self.view addSubview:phoneLineView];
    [self.view addSubview:passwordTF];
    [self.view addSubview:passwordLineView];
    [self.view addSubview:statusBtn];
    [self.view addSubview:forgetPasswordBtn];
    [self.view addSubview:sureBtn];
    
    
    
//    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(passwordTF);
//        make.right.equalTo(passwordTF);
//    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_NAVBAR_HEIGHT+12);
    }];
    
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.right.equalTo(self.view).with.offset(-46);
        make.height.mas_equalTo(30);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(60);
    }];
    
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(phoneTF);
        make.height.mas_equalTo(1);
        make.top.equalTo(phoneTF.mas_bottom).with.offset(1);
    }];
    
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(phoneTF);
        make.top.equalTo(phoneLineView.mas_bottom).with.offset(25);
    }];
    
    [passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(phoneLineView);
        make.top.equalTo(passwordTF.mas_bottom).with.offset(1);
    }];
    
    [statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLineView);
        make.top.equalTo(passwordLineView.mas_bottom).with.offset(15);
    }];
    
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusBtn);
        make.right.equalTo(passwordLineView);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.centerX.equalTo(self.view);
        make.top.equalTo(statusBtn.mas_bottom).with.offset(58);
    }];
}


- (UIButton *)publicStatusBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor colorWithHexString:CXWWriteColorStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:13];
    return  btn;
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
