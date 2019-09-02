//
//  UIFont+CXWFont.m
//  CarRank
//
//  Created by 陈叙文 on 2018/4/16.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UIFont+CXWFont.h"

@implementation UIFont (CXWFont)
+ (nullable UIFont *)CXWFontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0) {
        return [UIFont fontWithName:fontName size:fontSize];
    } else {
        // 针对 9.0 以下的iOS系统进行处理
        return [UIFont systemFontOfSize:fontSize];
    }
}
@end
