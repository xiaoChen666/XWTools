//
//  CXWBaseNavigationController.m
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/17.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWBaseNavigationController.h"
#import "UINavigationController+CXWCustomBar.h"
@interface CXWBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CXWBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CXWSetCustomBar];
    
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = self;
////        self.delegate = self;
//    }
    self.interactivePopGestureRecognizer.delegate = self;
  
    // Do any additional setup after loading the view.
}

///统一设置隐藏底部导航栏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) { //避免一开始就隐藏了
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    if (_isSingleWrite) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
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
