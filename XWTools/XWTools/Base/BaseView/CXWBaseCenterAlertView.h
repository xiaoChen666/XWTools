//
//  CXWBaseCenterAlertView.h
//  voiceAIApp
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXWBaseAlertView.h"
@interface CXWBaseCenterAlertView : CXWBaseAlertView

///添加子视图
- (void)CXWAddSubviews;

- (void)CXWSetBackBtnAndCancleBtn;

- (void)cxw_removeviewsAllView;


- (void)backgroundBtnClick;


@end
