//
//  XWTabbarController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWTabbarController.h"

#import "CXWBaseNavigationController.h"
#import "XWNewsHomeViewController.h"
#import "XWTestHomeViewController.h"
#import "XWMeHomeViewController.h"

#import "XWTabbar.h"

@interface XWTabbarController ()
@property (nonatomic, strong) CXWBaseNavigationController *testNavi;
@end

@implementation XWTabbarController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    XWTabbar *tabbar = [[XWTabbar alloc] init];
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setValue:tabbar forKey:@"tabBar"];
    [self setChildVC];
    
    [self hiddenTabbarTopLine];

    // Do any additional setup after loading the view.
}

- (void)hiddenTabbarTopLine {
    CGRect rect = CGRectMake(0, 0, KAPPWidth, KAppHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}



- (void)setChildVC {
    
    XWNewsHomeViewController *newsHome = [[XWNewsHomeViewController alloc] init];

    
    CXWBaseNavigationController *naviOne = [[CXWBaseNavigationController alloc] initWithRootViewController:newsHome];
    newsHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"育儿通" image:[[UIImage imageNamed:@"tabbar_unselect_baby"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_select_baby"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    newsHome.tabBarItem.tag = 1;
    
    XWTestHomeViewController *testHome = [[XWTestHomeViewController alloc] init];
    CXWBaseNavigationController *naviTwo = [[CXWBaseNavigationController alloc] initWithRootViewController:testHome];
//    testHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"测评" image:[[UIImage imageNamed:@"tabbar_visual_unseleted"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_visual_seleted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.testNavi = naviTwo;
//    testHome.tabBarItem.tag = 1;
    
    XWMeHomeViewController *meHome = [[XWMeHomeViewController alloc] init];
    CXWBaseNavigationController *naviThree = [[CXWBaseNavigationController alloc] initWithRootViewController:meHome];
    meHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_unselect_me"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_select_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meHome.tabBarItem.tag = 2;
    
    [self CXWVCPrivateAction:naviOne];
    [self CXWVCPrivateAction:naviTwo];
    [self CXWVCPrivateAction:naviThree];
    
    [self setViewControllers:@[naviOne,naviTwo,naviThree]];
    
  
}





- (void)CXWVCPrivateAction:(UIViewController*)VC {
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:13];
    attrSelected[NSForegroundColorAttributeName] = [UIColor colorWithHexString:CXWThemeColorStr];
    [VC.tabBarItem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    [VC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont CXWFontWithName:CXWPingFang_SC_Regular size:13],NSForegroundColorAttributeName:[UIColor colorWithHexString:CXWTestHighColorStr]} forState:UIControlStateNormal];
}




#pragma mark  ======Event======
- (void)centerBtnClick:(XWTabbarCenterBtn *)sender {
    self.selectedViewController = self.testNavi;
    sender.isSeleted = YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    XWTabbar *currentTabbar = (XWTabbar *)self.tabBar;
    if (item.tag!=0) {
        currentTabbar.centerBtn.isSeleted =NO;
    } else {
        currentTabbar.centerBtn.isSeleted = YES;
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
