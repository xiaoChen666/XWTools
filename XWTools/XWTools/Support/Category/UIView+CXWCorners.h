//
//  UIView+CXWCorners.h
//  CarRank
//
//  Created by 陈叙文 on 2018/7/21.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CXWCorners)

///添加顶部圆角
- (void)setCornerOnTop:(CGFloat )cornerRadius;
///添加底部圆角
- (void)setCornerOnBottom:(CGFloat )cornerRadius;

////设置渐变色
//- (void)CXWSetGradient;

@end
