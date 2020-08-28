//
//  XMPermenantThread.m
//  RunLoop
//
//  Created by xuwen_chen on 2020/8/27.
//  Copyright © 2020 xuwen_chen. All rights reserved.
//

#import "XMPermenantThread.h"

@interface XMThread : NSThread

@end


@implementation XMThread


- (void)dealloc {
    NSLog(@"--%s",__func__);
}


@end

@interface XMPermenantThread ()
@property (nonatomic, strong) XMThread *innerThread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;
@end

@implementation XMPermenantThread


- (instancetype)init {
    if (self = [super init]) {
        __weak typeof (self) weakSelf = self;
        self.innerThread = [[XMThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf&&!weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

/**
  开启一个线程
 **/
- (void)run {
    if (!self.innerThread) {
        return;
    }
    [self.innerThread start];
}


- (void)executeTaskWithBlock:(permenantTask)block {
    if (!self.innerThread || !block) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:block waitUntilDone:NO];
}




- (void)stop {
    if (!self.innerThread) return;

    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}


- (void)__stop {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(permenantTask)block {
    block();
}

- (void)dealloc {
    NSLog(@"--%s",__func__);
}


@end
