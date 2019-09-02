//
//  CXWAlertBackBtn.m
//  voiceAIApp
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWAlertBackBtn.h"

@implementation CXWAlertBackBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self CXWBaseAlertSetting];
    }
    return self;
}

- (void)CXWBaseAlertSetting {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.frame = CGRectMake(0, 0, KAPPWidth, KAppHeight);
}

@end
