//
//  UITextField+CXWTF.h
//  CarRank
//
//  Created by 陈叙文 on 2018/5/15.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CXWTF)

///设置光标的位置
- (void) setSelectedRange:(NSRange) range;

///设置占位文字的颜色
- (void)CXWSetPlaceHolderColor:(UIColor*)placeholderColor;

///设置占位文字的字体
- (void)CXWSetPlaceHolderFont:(UIFont*)placeholderFont;

///获取清空文字的按钮
- (UIButton*)CXWGetClearBtn;

//设置文字输入的起始位置 （用一个空的leftView）
- (void)CXWSetLeftMargin:(CGFloat)margin;

///设置密码输入的时候防止光标偏移
- (void)CXWSetSecureEntry:(BOOL)entry;

@end
