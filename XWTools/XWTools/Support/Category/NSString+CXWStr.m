//
//  NSString+CXWStr.m
//  CarRank
//
//  Created by 陈叙文 on 2018/5/4.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "NSString+CXWStr.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (CXWStr)

+ (NSString*)CXWRemoveStartEndSpaceWithStr:(NSString*)startSTr {
    if (kStringIsEmpty(startSTr))
    {
        return nil;
    }
    return  [startSTr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)CXWGetFirstLetterFromString:(NSString *)aString {
    /**
     * **************************************** START ***************************************
     * 之前PPGetAddressBook对联系人排序时在中文转拼音这一部分非常耗时
     * 参考博主-庞海礁先生的一文:iOS开发中如何更快的实现汉字转拼音 http://www.olinone.com/?p=131
     * 使PPGetAddressBook对联系人排序的性能提升 3~6倍, 非常感谢!
     */
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    /**
     *  *************************************** END ******************************************
     */
    
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self CXWPolyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
    
//    CXWLog(@"strPinYin----%@-pinyinString---%@",strPinYin,pinyinString);
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
}

+ (NSString *)CXWGetPinYinFromString:(NSString *)aString {
    
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    /**
     *  *************************************** END ******************************************
     */
    
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self CXWPolyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
    
    return strPinYin;
//    // 截取大写首字母
//    NSString *firstString = [strPinYin substringToIndex:1];
//    // 判断姓名首位是否为大写字母
//    NSString * regexA = @"^[A-Z]$";
//    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
//    // 获取并返回首字母
//    return [predA evaluateWithObject:firstString] ? firstString : @"#";
}

+(NSString *)GetFirstLetterFromPinyYin:(NSString*)pinyin {
        // 截取大写首字母
        NSString *firstString = [pinyin substringToIndex:1];
        // 判断姓名首位是否为大写字母
        NSString * regexA = @"^[A-Z]$";
        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
        // 获取并返回首字母
        return [predA evaluateWithObject:firstString] ? firstString : @"#";
}


/**
 多音字处理
 */
+ (NSString *)CXWPolyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString {
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}

- (BOOL)isGifImage {
    
    NSString *ext = self.pathExtension.lowercaseString;
    
    if ([ext isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getCompleteWebsite:(NSString *)urlStr{
    NSString *returnUrlStr = nil;
    NSString *scheme = nil;
    
    assert(urlStr != nil);
    
    urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (urlStr != nil) && (urlStr.length != 0) ) {
        NSRange  urlRange = [urlStr rangeOfString:@"://"];
        if (urlRange.location == NSNotFound) {
            returnUrlStr = [NSString stringWithFormat:@"http://%@", urlStr];
        } else {
            scheme = [urlStr substringWithRange:NSMakeRange(0, urlRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                returnUrlStr = urlStr;
            } else {
                //不支持的URL方案
            }
        }
    }
    return returnUrlStr;
}

///md5加密
+ (NSString *)md5HexDigest:(NSString*)password {
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        /*
         %02X是格式控制符：‘x’表示以16进制输出，‘02’表示不足两位，前面补0；
         */
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
//    NSString *mdfiveString = [hash copy];
    return mdfiveString;
}

//解码:从服务器请求数据,转成显示中文
+ (NSString *)ChangeToChinessEncode:(NSString *)fileTitleStr {
    if (fileTitleStr != NULL) {
        char *ReadStoreValue = (char *)[fileTitleStr cStringUsingEncoding:[NSString defaultCStringEncoding]];
        if ( ReadStoreValue != NULL )      {
            fileTitleStr = [NSString stringWithCString:ReadStoreValue encoding: -2147482062];
            }
    }
    return fileTitleStr;
}


//编码:
+ (NSString *)encodeString:(NSString *)string {
    NSString *urlEncoded = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(
                                                                                                  NULL,
                                                                                                  (__bridge CFStringRef) string,
                                                                                                  NULL,
                                                                                                  (CFStringRef) @"!*'\"();:@&=+$,?%#[]% ",
                                                                                                  kCFStringEncodingGB_18030_2000);
    return urlEncoded;
}


- (NSArray *)getAllRangeOfString:(NSString *)searchString {
    if (self.length <= 0 || !searchString || searchString.length <= 0) {
        return nil;
    }
    NSMutableArray * arr = [NSMutableArray array];
    NSString * newStr = [self copy];
    NSRange range = [newStr rangeOfString:searchString options:NSCaseInsensitiveSearch];
//    NSRange range = [newStr rangeOfString:searchString ];
    [arr addObject:[NSValue valueWithRange:range]];
    while (range.location != NSNotFound) {
        NSInteger start = range.location + range.length;
        if (start >= self.length) {
            break;
        }
        newStr = [self substringFromIndex:start];
        range = [newStr rangeOfString:searchString];
        range.location += start;
        [arr addObject:[NSValue valueWithRange:range]];
        
    }
    return arr;
}



@end
