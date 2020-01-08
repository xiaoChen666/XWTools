 //
//  PPHTTPRequest.m
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPHTTPRequest.h"
#import "PPInterfacedConst.h"
#import "PPNetworkHelper.h"

@implementation PPHTTPRequest



#pragma mark  ======数据统一处理=====

+ (CXWNetPublicModel*)CXWBackNetFailureModelWithError:(NSError*)error {
    if ([[CXWDataManager shareManager] CXWIsNetwork]) {
        [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:error.localizedDescription];
    }
    CXWNetPublicModel *model = [[CXWNetPublicModel alloc] init];
    model.requestCode = -10000;
    return model;
}

+ (void)CXWChuliDataWith:(id)responses AndSucessBlock:(void (^)(id responseObject))Sucess WithFailedBlock:(void (^)())Fail {
    
    if ([responses[@"Code"] integerValue]>0){
        if (Sucess) {
            Sucess(responses);
        }
    } else if ([responses[@"Code"] integerValue]==-102) {
        [[CXWJumpTools shareTool] CXWJumpToLoginVC];
        [[XWUserManager shareManager] xw_setLoginModel:nil];
        [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:responses[@"Msg"]];
        if (Fail) {
            Fail();
        }
    
    } else {
        if ([responses[@"Code"] integerValue] !=-125) {///屏蔽每日签到
            [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:responses[@"Msg"]];
        }
        if (Fail) {
            Fail();
        }
    }
}

+ (void)startNetwork:(CXWRequestComplete )complete {
    [PPNetworkHelper GET:@"http://www.baidu.com" parameters:nil success:^(id responseObject) {
        complete([CXWNetPublicModel new]);
    } failure:^(NSError *error) {
        complete([CXWNetPublicModel new]);
    }];
}

@end
