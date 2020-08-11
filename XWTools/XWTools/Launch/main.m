//
//  main.m
//  XWTools
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "objc/runtime.h"

typedef  void (^myBlock)(void);

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        myBlock block;
        
        NSObject *obj = [[NSObject alloc] init];
        myBlock block = ^{
            NSLog(@"----%@",obj);
         };
    
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
