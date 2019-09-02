//
//  CXWNOKeyBoardManagerViewController.m
//  voiceAIApp
//
//  Created by mac on 2018/9/26.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWNOKeyBoardManagerViewController.h"
#import "IQKeyboardManager.h"
@interface CXWNOKeyBoardManagerViewController ()

@end

@implementation CXWNOKeyBoardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
