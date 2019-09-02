//
//  XWLoginBaseViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWLoginBaseViewController.h"
#import "UIView+AZGradient.h"
#import "UITextField+CXWTF.h"
@interface XWLoginBaseViewController ()

@end

@implementation XWLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)CXWAddSubviews {
//    [self.view CXWSetPublicGradient];
    
    NSArray *colors = @[[UIColor colorWithHexString:@"#00C6FF"],[UIColor colorWithHexString:@"#1F83FF"]];
    [self.view az_setGradientBackgroundWithColors:colors locations:nil startPoint:CGPointMake(0.5, 0.5) endPoint:CGPointMake(0.5, 1.0)];
}


- (UILabel *)publicLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont CXWFontWithName:CXWPingFang_SC_Bold size:29];
    label.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    label.numberOfLines = 0;
    return label;
}

- (XWInputTF *)publicInputTF {
    XWInputTF *inputTF = [[XWInputTF alloc] init];
    inputTF.placeholder = @"哈";
    inputTF.xwPlaceholderColor = [[UIColor colorWithHexString:CXWWriteColorStr] colorWithAlphaComponent:0.5];
    inputTF.tintColor = [UIColor colorWithHexString:CXWWriteColorStr];
    inputTF.textColor = [UIColor colorWithHexString:CXWWriteColorStr];
    return inputTF;
}

- (CXWPublicSeparatorView *)publicLineView {
    CXWPublicSeparatorView *lineView = [[CXWPublicSeparatorView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    return lineView;
}

- (UIButton *)publicTopBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor colorWithHexString:CXWWriteColorStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:17];
    return btn;
}


- (UIButton *)publicSureBtn {
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitleColor:[UIColor colorWithHexString:CXWThemeColorStr] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:16];
    sureBtn.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    sureBtn.layer.cornerRadius = 17.5;
    
    sureBtn.layer.shadowOffset = CGSizeMake(4, 4);
    sureBtn.layer.shadowRadius = 2;
    sureBtn.layer.shadowColor = [UIColor colorWithHexString:@"#7DCBFF"].CGColor;
    sureBtn.layer.shadowOpacity = 1.0;
    return sureBtn;
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
