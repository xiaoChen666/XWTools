//
//  CXWPublicSeparatorView.m
//  voiceAIApp
//
//  Created by mac on 2018/9/21.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWPublicSeparatorView.h"

@implementation CXWPublicSeparatorView

- (instancetype)init {
    if (self = [super init]) {
        [self cxw_baseSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self cxw_baseSetting];
    }
    return self;
}

- (void)cxw_baseSetting {
    self.backgroundColor = [UIColor colorWithHexString:CXWSeparatorLineColorStr];
}

@end
