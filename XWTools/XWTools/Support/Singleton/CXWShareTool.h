//
//  CXWShareTool.h
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXWShareTool : NSObject

+(instancetype) defaultTool;//单例方法


#pragma mark 分享

/** 普通分享*/
- (void)CXWSharePicWithDic:(NSDictionary*)para WithVC:(UIViewController*)VC;

/** 分享视频*/
- (void)CXWShareVideoWithDic:(NSDictionary*)para WithVC:(UIViewController*)VC;


@end
