//
//  XWUserManager.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWUserManager.h"

@interface XWUserManager ()
@property (nonatomic, strong) XWUserModel *MyUserModel;
///是否已经从本地获取了数据
@property (nonatomic, assign) BOOL isGetValueFromLocal;
@end

@implementation XWUserManager

static XWUserManager* _shareManager = nil;
+(instancetype) shareManager {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shareManager = [[super allocWithZone:NULL] init] ;
    }) ;
    return _shareManager ;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    return [XWUserManager shareManager] ;
}

-(id) copyWithZone:(struct _NSZone *)zone {
    return [XWUserManager shareManager] ;
}


//返回登录模型
- (XWUserModel *)userModel {
    if (self.isGetValueFromLocal) {
        return self.MyUserModel;
    }
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:CXWLoginModelKey];
    XWUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    self.MyUserModel = userModel;
    return userModel;
}


- (void)xw_setLoginModel:(XWUserModel *)model {
    XWUserModel *anotherModel ;
    if (kObjectIsEmpty(model)) {
        anotherModel = [[XWUserModel alloc] init];
    }else {
        anotherModel = model;
    }
    self.MyUserModel = anotherModel;
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:anotherModel];
    [KAPPUserDefaultes setObject:data forKey:CXWLoginModelKey];
    [KAPPUserDefaultes synchronize];
}


- (void)setMyUserModel:(XWUserModel *)MyUserModel {
    _MyUserModel = MyUserModel;
    self.isGetValueFromLocal = YES;
    
    if (kStringIsEmpty(MyUserModel.NickName)) {
        _isLogin =  NO;
    }
    else {
        _isLogin = YES;
    }
    
    if (MyUserModel.HasCustomerInfo==1) {
        _HasCustomerInfo = YES;
    } else {
        _HasCustomerInfo = NO;
    }
}


@end
