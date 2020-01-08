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
#import <iconv.h>

//static NSString *const PSW_AES_KEY = @"TESTPASSWORD";
//static NSString *const AES_IV_PARAMETER = @"AES00IVPARAMETER";

//static NSString *const PSW_AES_KEY = @"56fkeceBHOzAkmT4jl/XbA==";
static NSString *const PSW_AES_KEY = nil;
static NSString *const AES_IV_PARAMETER =  nil;

@implementation NSString (AES)


- (NSString*)aci_encryptWithAESWithKey:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];

    
        NSString *newResult= [self hexStringWithData:encryptData];;
        
        return newResult;
        //对加密后的二进制数据进行base64转码
//        return [self encodeBase64Data:encryptData] ;
    }
    else
    {
        free(buffer);
        return nil;
    }
    
}

-(NSString *)hexStringWithData:(NSData *)data
{
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    NSString* result = [NSString stringWithString:hexString];
    return result;
    
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
    
//   NewData =  [GTMBase64 decodeData:NewData];
    
//    key = [NewData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   
    
    
//    char keyPtr[kCCKeySizeAES128 + 1];
//    char keyPtr[kCCKeySizeAES128 ];
//    bzero(keyPtr, sizeof(keyPtr));
    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    //    char keyPtr[kCCKeySizeAES256 + 1];
    //    bzero(keyPtr, sizeof(keyPtr));
    //    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
  char* keyPtr = [NewData bytes];
    
    
    // IV
//    char ivPtr[kCCBlockSizeAES128 + 1];
     char ivPtr[kCCKeySizeAES256 + 1];
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
