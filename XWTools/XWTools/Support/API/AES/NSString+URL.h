//
//  NSString+URL.h
//  AES
//
//  Created by 陈叙文 on 2017/12/19.
//  Copyright © 2017年 张义. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
