//
//  SVProgressHUD+CXWSVHUD.h
//  CarRank
//
//  Created by 陈叙文 on 2018/6/22.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "SVProgressHUD.h"

@interface SVProgressHUD (CXWSVHUD)

///没有用户交互的
+ (void)CXWShowSVProgressHUD;

///有用户交互的
+ (void)CXWShowSVProgressHUDWithUserInfo;

+ (void)CXWDismissSVProgressHUD;

+ (void)CXWShowWithMessage:(NSString *)message;
@end
