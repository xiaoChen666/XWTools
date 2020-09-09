//
//  XMTimer.h
//  定时器
//
//  Created by xuwen_chen on 2020/9/5.
//  Copyright © 2020 xuwen_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTimer : NSObject


+ (NSString *)execTask:(void(^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeat
           async:(BOOL)async;


+ (NSString *)execTask:(id)targe
   selector:(SEL)seletor
   start:(NSTimeInterval)start
interval:(NSTimeInterval)interval
 repeats:(BOOL)repeat
   async:(BOOL)async;


+ (void )cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
