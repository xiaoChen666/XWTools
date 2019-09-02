//
//  CXWBaseCollectionView.m
//  CarRank
//
//  Created by 陈叙文 on 2018/4/12.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWBaseCollectionView.h"

@implementation CXWBaseCollectionView

- (instancetype)init {
    if (self = [super init]) {
        [self CXWBaseSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self CXWBaseSetting];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self CXWBaseSetting];
    }
    return self;
}
- (void)CXWBaseSetting {
    self.backgroundColor = [UIColor colorWithHexString:CXWVCBacKColorStr];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
- (void)dealloc {
    CXWLog(@"delloc---%@",self.class);
}
@end
