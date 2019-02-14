//
//  CXWCacheTool.h
//  CarRank
//
//  Created by 陈叙文 on 2018/8/3.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CXWPublicVoidBlock)();
@interface CXWCacheTool : NSObject
+(instancetype) defaultTool;//单例方法

///返回所有缓存的大小
- (NSString*)CXWGetTotolSize;

- (void)cxw_clearAllCache:(CXWPublicVoidBlock)block;

@end
