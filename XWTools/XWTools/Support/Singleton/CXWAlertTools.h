//
//  CXWAlertTools.h
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/20.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXWAlertTools : NSObject

+ (instancetype) shareTools;//单例方法

- (void)CXWAlertTrueMessageWithTitle:(NSString *)title;

- (void)CXWAlertErrorMessageWithTitle:(NSString *)title ;

@end
