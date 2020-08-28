//
//  XMPermenantThread.h
//  RunLoop
//
//  Created by xuwen_chen on 2020/8/27.
//  Copyright © 2020 xuwen_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^permenantTask)(void);

@interface XMPermenantThread : NSObject


/**
  开启一个线程
 **/
- (void)run;


- (void)executeTaskWithBlock:(permenantTask)block;

- (void)stop;

@end


