//
//  PPHTTPRequest.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXWNetPublicModel.h"

/*
 以下Block的参数你根据自己项目中的需求来指定, 这里仅仅是一个演示的例子
 */

/**
 请求成功的block
 
 @param response 响应体数据
 */
typedef void(^PPRequestSuccess)(id response);
/**
 请求失败的block
 
 */
typedef void(^PPRequestFailure)(NSError *error);

typedef void (^CXWRequestComplete)(CXWNetPublicModel *NetModel);


@interface PPHTTPRequest : NSObject

#pragma mark  ======系统信息======

@end
