//
//  XWRegisterSetPhoneViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWRegisterSetPhoneViewController.h"

#import "XWLoginViewController.h"
#import "XWRegisterSetPasswordViewController.h"
@interface XWRegisterSetPhoneViewController ()
@property (nonatomic,strong) XWInputTF *phoneTF;
@end

@implementation XWRegisterSetPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loginBtnClick {
    
    for (UIViewController *VC in self.navigationController.childViewControllers) {
        if ([VC isKindOfClass:[XWLoginViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
            return;
        }
    }
    XWLoginViewController *VC = [[XWLoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)protocolBtnClick:(UIButton *)sender {

}

- (void)sureBtnClick {

}

#pragma mark  ======UI======

- (void)CXWAddNaviSubviews {
    UIButton *rightBtn = [self publicTopBtn];
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-25);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_STATUSHEIGHT+23);
    }];
}

- (void)CXWAddSubviews {
    
    [super CXWAddSubviews];
    
    UILabel *titleLabel = [self publicLabel];
    titleLabel.text = @"注册\n欢迎使用测评";
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:12];
    contentLabel.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    contentLabel.text = @"注册代表您已同意";
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocolBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSAttributedString *protocalStr = [[NSAttributedString alloc] initWithString:@"《超级宝宝测评使用条款及隐私政策》" attributes:@{NSFontAttributeName:[UIFont CXWFontWithName:CXWPingFang_SC_Bold size:13],NSForegroundColorAttributeName:[UIColor colorWithHexString:CXWWriteColorStr],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    
    [protocolBtn setAttributedTitle:protocalStr forState:UIControlStateNormal];
    
    XWInputTF *phoneTF = [self publicInputTF];
    phoneTF.placeholder = @"请输入手机号码";
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    UIButton *sureBtn = [self publicSureBtn];
    [sureBtn setTitle:@"发送手机验证码" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CXWPublicSeparatorView *phoneLineView = [self publicLineView];
    
    self.phoneTF = phoneTF;
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:contentLabel];
    [self.view addSubview:protocolBtn];
    [self.view addSubview:phoneTF];
    [self.view addSubview:sureBtn];
    [self.view addSubview:phoneLineView];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.top.equalTo(self.view).with.offset(CURRENTSCREN_NAVBAR_HEIGHT+12);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(20);
    }];
    
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel);
        make.top.equalTo(contentLabel.mas_bottom);
    }];
    
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(46);
        make.right.equalTo(self.view).with.offset(-46);
        make.height.mas_equalTo(30);
        make.top.equalTo(protocolBtn.mas_bottom).with.offset(100);
    }];
    
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(phoneTF);
        make.height.mas_equalTo(1);
        make.top.equalTo(phoneTF.mas_bottom);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.centerX.equalTo(self.view);
        make.top.equalTo(phoneTF.mas_bottom).with.offset(58);
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
