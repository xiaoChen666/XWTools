//
//  XWOtherTextCodeVerifyViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWOtherTextCodeVerifyViewController.h"
#import "XWImageVerifyView.h"

@interface XWOtherTextCodeVerifyViewController ()

@end

@implementation XWOtherTextCodeVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"后台图形验证码";
    
    XWImageVerifyView *imageV = [[XWImageVerifyView alloc] init];
    [self.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 150));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.view).with.offset(150);
    }];
    
    
    imageV.pointArrBlock = ^(NSArray * _Nonnull pointArr) {
        NSLog(@"----%@",pointArr);
    };
    
}




@end
