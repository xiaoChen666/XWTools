//
//  NSString+ConvertEncoding.m
//  NSStringConvertEncodingDemo
//
//  Created by JiongXing on 2016/11/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "NSString+ConvertEncoding.h"

@implementation NSString (ConvertEncoding)

- (instancetype)convertToGBKCharacters {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self convertToCharactersWithEncoding:encoding];
}

- (instancetype)convertToGBKCode {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self convertToCodeWithEncoding:encoding];
}

- (instancetype)convertToUTF8Characters {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    return [self convertToCharactersWithEncoding:encoding];
}

- (instancetype)convertToUTF8Code {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    return [self convertToCodeWithEncoding:encoding];
}

- (instancetype)convertToCharactersWithEncoding:(NSStringEncoding)encoding {
    NSData *data = [self convertToHexData];
    return [[NSString alloc] initWithData:data encoding:encoding];
}

- (instancetype)convertToCodeWithEncoding:(NSStringEncoding)encoding {
    NSData *data = [self dataUsingEncoding:encoding];
    return [NSString hexStringFromData:data];
}

- (NSData *)convertToHexData {
    if (!self || [self length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([self length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [self length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [self substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (instancetype)hexStringFromData:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

@end
