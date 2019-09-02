//
//  CXWPublicArrowIMGV.m
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/20.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWPublicArrowIMGV.h"

@implementation CXWPublicArrowIMGV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       [self cxw_baseSetting];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self cxw_baseSetting];
    }
    return self;
}

- (void)cxw_baseSetting{
    self.image = [UIImage imageNamed:@"public_arrow"];
}

@end
