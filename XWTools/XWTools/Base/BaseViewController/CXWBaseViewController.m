//
//  CXWBaseViewController.m
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/17.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWBaseViewController.h"
#import "XWLoginBaseViewController.h"
#import "XWWelcomeViewController.h"
#import "TOCropViewController.h"
#import "XWTestHomeViewController.h"

@interface CXWBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation CXWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 2. 导航控制器代理
    self.navigationController.delegate = self;
}


#pragma mark - Private Methods
#pragma mark -
#pragma mark Whether need Navigation Bar Hidden
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    BOOL needHideNaivgaionBar = NO;
    ///需要隐藏导航栏的控制器    XWWelcomeViewController TOCropViewController XWFillMessageViewController
    if (([viewController isKindOfClass: [XWWelcomeViewController class]])||
        ([viewController isKindOfClass: [TOCropViewController class]])||
        ([viewController isKindOfClass: [XWLoginBaseViewController class]])||
        ([viewController isKindOfClass: [XWTestHomeViewController class]])
        ) {
        needHideNaivgaionBar = YES;
    }
    return needHideNaivgaionBar;
}

#pragma mark - UINaivgationController Delegate
#pragma mark -
#pragma mark Will Show ViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self.navigationController setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                                             animated: animated];
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
