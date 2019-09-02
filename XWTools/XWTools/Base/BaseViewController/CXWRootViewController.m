//
//  CXWBaseRootViewController.m
//  CarRank
//
//  Created by 陈叙文 on 2018/7/5.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWRootViewController.h"

@interface CXWRootViewController ()

@end

@implementation CXWRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
//    self.tabBarController.tabBar.translucent = NO;
    if (@available(iOS 11.0, *)) {
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:CXWVCBacKColorStr];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self CXWAddNaviSubviews];
    [self CXWAddSubviews];
    

    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [SVProgressHUD CXWDismissSVProgressHUD];
//}


///添加子视图
- (void)CXWAddSubviews {
    
}

///添加导航栏
- (void)CXWAddNaviSubviews {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    CXWLog(@"---%@",self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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

