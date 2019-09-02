//
//  NSString+ConvertEncoding.h
//  NSStringConvertEncodingDemo
//
//  Created by JiongXing on 2016/11/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConvertEncoding)

#pragma mark - GBK
/// 把十六进制GBK编码转成文字
- (instancetype)convertToGBKCharacters;

/// 把文字转成十六进制GBK编码
- (instancetype)convertToGBKCode;


#pragma mark - UTF8
/// 把十六进制UTF8编码转成文字
- (instancetype)convertToUTF8Characters;

/// 把文字转成十六进制UTF8编码
- (instancetype)convertToUTF8Code;


#pragma mark - Public
/// 把十六进制编码转成文字
- (instancetype)convertToCharactersWithEncoding:(NSStringEncoding)encoding;

/// 把文字转成十六进制编码
- (instancetype)convertToCodeWithEncoding:(NSStringEncoding)encoding;

/// 把十六进制字符串转成NSData
- (NSData *)convertToHexData;

/// 把NSData转成十六进制字符串
+ (instancetype)hexStringFromData:(NSData *)data;

@end
