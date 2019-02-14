//
//  NSString+AES.m
//  
//
//  Created by Bear on 16/11/26.
//  Copyright © 2016年 Bear . All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "NSString+URL.h"
//static NSString *const PSW_AES_KEY = @"TESTPASSWORD";
//static NSString *const AES_IV_PARAMETER = @"AES00IVPARAMETER";

//static NSString *const PSW_AES_KEY = @"56fkeceBHOzAkmT4jl/XbA==";
static NSString *const PSW_AES_KEY = nil;
static NSString *const AES_IV_PARAMETER =  nil;

@implementation NSString (AES)


- (NSString*)aci_encryptWithAES {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    

    

    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    NSString *baseStr_GTM = [self encodeBase64Data:AESData];
    
    
    baseStr_GTM = [baseStr_GTM URLEncodedString];
    
    
//    NSString *baseStr = [AESData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    

    
//    CXWLog(@"*****************\nGTMBase:%@\n*****************", baseStr_GTM);
//    CXWLog(@"*****************\niOSCode:%@\n*****************", baseStr);
    return baseStr_GTM;
}

- (NSString*)aci_decryptWithAES {
    
    NSString *newStr = [self URLDecodedString];
    
    if (kStringIsEmpty(newStr))
    {
        return nil;
    }
    
    
    NSData *data = [newStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *baseData_GTM = [newStr decodeBase64Data:data];
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:newStr options:0];
    
    NSString *hahahha = [[NSString alloc] initWithData:baseData encoding:NSUTF8StringEncoding];
    
    NSData *AESData_GTM = [newStr AES128operation:kCCDecrypt
                                           data:baseData_GTM
                                            key:PSW_AES_KEY
                                             iv:AES_IV_PARAMETER];
    NSData *AESData = [newStr AES128operation:kCCDecrypt
                                       data:baseData
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    
//    NSString *decStr_GTM = [[NSString alloc] initWithData:AESData_GTM encoding:NSUTF8StringEncoding];
    NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    
    return decStr;
}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 */
- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    
    NSData *NewData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
   NewData =  [GTMBase64 decodeData:NewData];
    
//    key = [NewData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   
    
    
//    char keyPtr[kCCKeySizeAES128 + 1];
//    char keyPtr[kCCKeySizeAES128 ];
//    bzero(keyPtr, sizeof(keyPtr));
    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
  char* keyPtr = [NewData bytes];
    
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    

    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    
    
    if(cryptorStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}

/**< GTMBase64编码 */
- (NSString*)encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    
   
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

/**< GTMBase64解码 */
- (NSData*)decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    return data;
}

- (NSString *)XWBase64 {
    if (kStringIsEmpty(self)) {
        return nil;
    }
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    NSString *base64Str = [[NSString alloc] initWithData:baseData encoding:NSUTF8StringEncoding];
    
    return base64Str;
}

@end
