//
//  CXWBaseAlertView.m
//  voiceAIApp
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWBaseAlertView.h"

@implementation CXWBaseAlertView

- (UIWindow *)publicWindow {
    return [UIApplication sharedApplication].delegate.window;
}

- (CXWAlertBackBtn *)publicBackBtn {
    return [CXWAlertBackBtn buttonWithType:UIButtonTypeCustom];
}

@end
