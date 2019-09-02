//
//  CXWNetPublicModel.m
//  voiceAIApp
//
//  Created by mac on 2018/9/21.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWNetPublicModel.h"

@implementation CXWNetPublicModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.message = dic[@"Msg"];
        self.scoreModel = [[CXWNetPublicScoreModel alloc] initWithDictionary:dic[@"ScoreData"] error:nil];
        self.requestCode = [dic[@"Code"] integerValue];
        
        CXWLog(@"---%@",[self descriptionWithDic:dic]);
    }
    return self;
}

- (NSString *)descriptionWithDic:(NSDictionary *)dic {
    NSArray *allKeys = [dic allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys){
        id value= dic[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    return str;
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"%@---%@----%@---%@---%@",self.code,self.version,self.message,self.pageModel,self.tagModel];
//}
@end
