//
//  NSString+Chinese.m
//  CarRank
//
//  Created by 陈叙文 on 2018/2/28.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "NSString+Chinese.h"

@implementation NSString (Chinese)
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
