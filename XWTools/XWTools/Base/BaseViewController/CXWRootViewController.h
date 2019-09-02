//
//  CXWRootViewController.h
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/17.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXWRootViewController : UIViewController

@property (nonatomic, strong) NSURLSessionTask *currentURLTask;


///添加子视图
- (void)CXWAddSubviews;

///添加导航栏
- (void)CXWAddNaviSubviews;

@end
