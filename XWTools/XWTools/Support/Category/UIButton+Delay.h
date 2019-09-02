//
//  UIButton+Delay.h
//  KPTXXCfood
//
//  Created by 万俊 on 2017/8/4.
//  Copyright © 2017年 szkpkc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Delay)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; //延时不能响应点击事件

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;
@end
