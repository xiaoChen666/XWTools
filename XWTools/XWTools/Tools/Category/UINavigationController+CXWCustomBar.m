//
//  UINavigationController+CXWCustomBar.m
//  CarRank
//
//  Created by 陈叙文 on 2018/4/14.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UINavigationController+CXWCustomBar.h"
#import "UIImage+Extension.h"
#import "UIView+AZGradient.h"
@implementation UINavigationController (CXWCustomBar)
/**设置自定义的导航栏*/
- (void)CXWSetCustomBar {
    
    self.navigationBar.tintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF"],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    self.navigationBar.translucent = NO;
    //CXWBack
    NSString *imageStr = @"";

    UIImage *backButtonImage = [UIImage imageNamed:imageStr];
    
    self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    
    self.navigationBar.backIndicatorImage = backButtonImage;
    
    [self.navigationBar setBackgroundImage:[UIImage convertViewToImage:[self cxw_backgradView]] forBarMetrics:UIBarMetricsDefault];
}

- (UIView *)cxw_backgradView {
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KAPPWidth, CURRENTSCREN_NAVBAR_HEIGHT)];
    [backView CXWSetPublicGradient];
    return backView;
    
}




@end
