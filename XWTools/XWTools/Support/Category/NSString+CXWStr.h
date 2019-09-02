//
//  NSString+CXWStr.h
//  CarRank
//
//  Created by 陈叙文 on 2018/5/4.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXWStr)
/**去除收尾空格*/
+ (NSString*)CXWRemoveStartEndSpaceWithStr:(NSString*)startSTr;

#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)CXWGetFirstLetterFromString:(NSString *)aString;

//获取拼音
+ (NSString *)CXWGetPinYinFromString:(NSString *)aString;

//从拼音获取首字母
+(NSString *)GetFirstLetterFromPinyYin:(NSString*)pinyin;

//判断是否是gif的链接
- (BOOL)isGifImage;

//获取可以直接使用的链接
+ (NSString *)getCompleteWebsite:(NSString *)urlStr;

///md5加密
+ (NSString *)md5HexDigest:(NSString*)password;


//解码:从服务器请求数据,转成显示中文
+(NSString *)ChangeToChinessEncode:(NSString *)fileTitleStr;

//编码:
+(NSString *)encodeString:(NSString *)string ;
@end
