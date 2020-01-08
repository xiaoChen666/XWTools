//
//  AppDelegate.m
//  XWTools
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AppDelegate.h"

#import "XWWelcomeViewController.h"
#import "XWTabbarController.h"
#import "PPHTTPRequest.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    if ([[CXWDataManager shareManager] isFirstLaunch]) {
//        self.window.rootViewController = [[XWWelcomeViewController alloc] init];
        XWTabbarController *tab =  [[XWTabbarController alloc] init];
        self.window.rootViewController = tab;
    } else {
        self.window.rootViewController = [[XWTabbarController alloc] init];
    }
    
    NSLog(@"开始--%@",[NSDate date]);
    [PPHTTPRequest startNetwork:^(CXWNetPublicModel *NetModel) {
        //
    }];
    
    
    NSLog(@"--sdasdkasdask");
    
    [self.window makeKeyAndVisible];
    
    
    
    
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KAPPWidth, KAppHeight)];
//
//    CGSize viewSize = [UIScreen mainScreen].bounds.size;
//    NSString *viewOr = @"Portrait";//垂直
//    NSString *launchImage = nil;
//    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
//
//    for (NSDictionary *dict in launchImages) {
//        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
//
//        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
//            launchImage = dict[@"UILaunchImageName"];
//        }
//    }
//
//    imgV.image = [UIImage imageNamed:launchImage];
//    [[UIApplication sharedApplication].delegate.window addSubview:imgV];
    
    
   
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
