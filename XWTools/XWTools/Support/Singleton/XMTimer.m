//
//  XMTimer.m
//  定时器
//
//  Created by xuwen_chen on 2020/9/5.
//  Copyright © 2020 xuwen_chen. All rights reserved.
//

#import "XMTimer.h"

@implementation XMTimer


static NSMutableDictionary *timers;
static dispatch_semaphore_t semaphore_;
+ (void)initialize {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
    
   
    
}


+ (NSString *)execTask:(void(^)(void))task
   start:(NSTimeInterval)start
interval:(NSTimeInterval)interval
 repeats:(BOOL)repeat
           async:(BOOL)async {
    
    
    if (!task || start<0 ||interval <=0) {
        return nil;
    }


    
    dispatch_queue_t queue = async?dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL):dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    NSString *name = [NSString stringWithFormat:@"%zd",timers.count];
    timers[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC), interval*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer,^{
        task();
        if (!repeat) {
            [self cancelTask:name];
        }
    });
    
    dispatch_resume(timer);
    
   
    
    return name;
}

+ (NSString *)execTask:(id)targe
   selector:(SEL)seletor
   start:(NSTimeInterval)start
interval:(NSTimeInterval)interval
 repeats:(BOOL)repeat
                 async:(BOOL)async {
    
    if (!targe  || !seletor) {
        return nil;
    }
    
    return [self execTask:^{
        
        if ([targe respondsToSelector:seletor]) {
            
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            [targe performSelector:seletor];
            
            #pragma clang diagnostic pop
            
        }
    } start:start interval:interval repeats:repeat async:async];
    
    
}


+ (void )cancelTask:(NSString *)name {
    if (name.length == 0) {
        return;
    }
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t time = timers[name];
    
    if (time) {
        dispatch_source_cancel(timers[name]);
        [timers removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(semaphore_);
}

@end
