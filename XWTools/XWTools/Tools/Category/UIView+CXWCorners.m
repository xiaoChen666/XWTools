//
//  UIView+CXWCorners.m
//  CarRank
//
//  Created by 陈叙文 on 2018/7/21.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UIView+CXWCorners.h"

@implementation UIView (CXWCorners)
///添加顶部圆角
- (void)setCornerOnTop:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
///添加底部圆角
- (void)setCornerOnBottom:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
