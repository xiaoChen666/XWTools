//
//  CXWJumpTools.m
//  CarRank
//
//  Created by 陈叙文 on 2018/2/27.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWJumpTools.h"
#import "CXWBaseNavigationController.h"
#import "NSDate+Extension.h"

#import "XWLoginViewController.h"
@implementation CXWJumpTools

#pragma mark --单例
static CXWJumpTools* _shareTool = nil;

+(instancetype) shareTool {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shareTool = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _shareTool ;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    return [CXWJumpTools shareTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone {
    return [CXWJumpTools shareTool] ;
}

- (void)xw_jumpWithModel:(XWAdCardListModel *)model {

}

- (void)CXWJumpToLoginVC {
    
    XWLoginViewController*login = [[XWLoginViewController alloc] init];
    CXWBaseNavigationController *navi = [[CXWBaseNavigationController alloc] initWithRootViewController:login];
    [UIApplication sharedApplication].delegate.window.rootViewController = navi;
    
}
@end
