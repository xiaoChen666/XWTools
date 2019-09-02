//
//  XWUserManager.h
//  SuperBabyTest
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWUserManager : NSObject
+(instancetype)shareManager;

#pragma mark  ======具体方法======
//用来获取登录模型
@property (nonatomic, strong,readonly) XWUserModel *userModel;

///是否已经登录
@property (nonatomic, assign,readonly) BOOL isLogin;

///是否已经填写用户信息
@property (nonatomic, assign,readonly) BOOL HasCustomerInfo;

//设置登录模型 为空 或者更新
- (void)xw_setLoginModel:(XWUserModel*)model;
@end

NS_ASSUME_NONNULL_END
