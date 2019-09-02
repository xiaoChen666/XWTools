//
//  CXWJumpTools.h
//  CarRank
//
//  Created by 陈叙文 on 2018/2/27.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWAdCardListModel;
@interface CXWJumpTools : NSObject
+(instancetype) shareTool;//单例方法


- (void)xw_jumpWithModel:(XWAdCardListModel *)model;


///跳转到登录界面
- (void)CXWJumpToLoginVC;
@end
