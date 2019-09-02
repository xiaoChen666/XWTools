//
//  CXWBaseCenterAlertView.m
//  voiceAIApp
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWBaseCenterAlertView.h"
#import "CXWAlertBackBtn.h"
@interface CXWBaseCenterAlertView ()
@property (nonatomic, strong) CXWAlertBackBtn *backBtn;
@end
@implementation CXWBaseCenterAlertView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self CXWAddSubviews];
    }
    return self;
}

- (void)CXWAddSubviews {
    
}


- (void)CXWSetBackBtnAndCancleBtn {


    self.backBtn = [CXWAlertBackBtn buttonWithType:UIButtonTypeCustom];
    [self.backBtn addTarget:self action:@selector(backgroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    [window addSubview:self.backBtn];
    [self.backBtn addSubview:self];

}


#pragma mark  ======Event======
- (void)backgroundBtnClick {

}

- (void)cxw_removeviewsAllView {
    
    [self removeFromSuperview];
    [self.backBtn removeFromSuperview];
    
}


@end
