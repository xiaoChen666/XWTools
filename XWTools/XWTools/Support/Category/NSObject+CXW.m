//
//  NSObject+CXW.m
//  CarRank
//
//  Created by 陈叙文 on 2018/7/20.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "NSObject+CXW.h"
#include <objc/runtime.h>
@implementation NSObject (CXW)
- (BOOL)containsNilObject {
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t propertyValue = properties[i];
        const char *propertyName = property_getName(propertyValue);
        SEL getSeletor = NSSelectorFromString([NSString stringWithUTF8String:propertyName]);
        
        if ([self respondsToSelector:getSeletor]) {
            NSMethodSignature *signature = [self methodSignatureForSelector:getSeletor];//方法签名
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];//调用对象
            [invocation setTarget:self];//设置target
            [invocation setSelector:getSeletor];//设置selector
            NSObject *__unsafe_unretained returnValue = nil;//设置返回值
            [invocation invoke];//开始调用
            [invocation getReturnValue:&returnValue];//接收返回值
            if (returnValue == nil) {
                return YES;
            }
        }
    }
    return NO;
}
@end
