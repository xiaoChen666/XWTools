//
//  UIView+Extension.h
//  XMPlayer
//
//  Created by min on 2017/10/31.
//  Copyright © 2017年 min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat left;
@end
