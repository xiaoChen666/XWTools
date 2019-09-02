//
//  CXWNetPublicModel.h
//  voiceAIApp
//
//  Created by mac on 2018/9/21.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXWRootModel.h"
#import "CXWNetPublicScoreModel.h"
@interface CXWNetPublicModel : CXWRootModel

//-102 token过期 -114 -10000自定义直接返回失败跟后台无关
@property (nonatomic, assign) BOOL CXWSuccessRequest;

@property (nonatomic, assign) NSInteger requestCode;

@property (nonatomic ,copy) NSString *message;

@property (nonatomic, strong) id resultData;

@property (nonatomic, strong) CXWNetPublicScoreModel *scoreModel;

- (instancetype)initWithDic:(NSDictionary*)dic;
@end
