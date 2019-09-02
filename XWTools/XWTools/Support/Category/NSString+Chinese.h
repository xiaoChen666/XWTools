//
//  NSString+Chinese.h
//  CarRank
//
//  Created by 陈叙文 on 2018/2/28.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chinese)
- (BOOL)isChinese;//判断是否是纯汉字

- (BOOL)includeChinese;//判断是否含有汉字
@end
