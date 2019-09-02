//
//  SVProgressHUD+CXWSVHUD.m
//  CarRank
//
//  Created by 陈叙文 on 2018/6/22.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "SVProgressHUD+CXWSVHUD.h"

@implementation SVProgressHUD (CXWSVHUD)

///没有用户交互的
+ (void)CXWShowSVProgressHUD{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD CXWSVProgressHUDPublicSetting];
    [SVProgressHUD show];
}

///有用户交互的
+ (void)CXWShowSVProgressHUDWithUserInfo {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD CXWSVProgressHUDPublicSetting];
    [SVProgressHUD show];
}

+ (void)CXWDismissSVProgressHUD {
    [SVProgressHUD dismiss];
}

+ (void)CXWShowWithMessage:(NSString *)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:CXWThemeColorStr]];
    [SVProgressHUD setBackgroundColor: [UIColor whiteColor]];
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}


#pragma mark  ======private=====
///加载框公共设置
+ (void)CXWSVProgressHUDPublicSetting {
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:CXWThemeColorStr]];
    [SVProgressHUD setBackgroundColor: [UIColor clearColor]];
}


@end
