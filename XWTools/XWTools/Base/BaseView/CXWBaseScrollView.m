//
//  CXWBaseScrollView.m
//  CarRank
//
//  Created by 陈叙文 on 2018/4/18.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWBaseScrollView.h"

@implementation CXWBaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    if (self = [super init])
    {
        //
        [self CXWBaseSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self CXWBaseSetting];
    }
    return self;
}
- (void)CXWBaseSetting
{
    self.backgroundColor = [UIColor colorWithHexString:CXWVCBacKColorStr];
    self.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
- (void)dealloc{
    
    CXWLog(@"delloc---%@",self.class);
}
@end
