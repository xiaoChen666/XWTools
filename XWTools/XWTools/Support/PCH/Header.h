//
//  Header.h
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#ifndef Header_h
#define Header_h


/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#define ProductSever 1
#define TestSever    0
#define LocalSever 0


#pragma mark ---公用文件
#ifdef __OBJC__
#import "YYKit.h"
#import "CXWConst.h"
#import "CXWPublicBlock.h"
#import "CXWDataManager.h"
#import "UIView+Extension.h"
#import "UIFont+CXWFont.h"
#import "CXWBaseTabView.h"
#import "CXWBaseCollectionView.h"
#import "CXWBaseTableViewCell.h"
#import "CXWBaseCollectionViewCell.h"
#import "CXWBaseViewController.h"
#import "Masonry.h"
#import "CXWPublicArrowIMGV.h"
#import "CXWAlertTools.h"
#import "CXWJumpTools.h"
#import "CXWPublicSeparatorView.h"
#import "SVProgressHUD+CXWSVHUD.h"
#import "CXWBaseBtn.h"
#import "UIColor+CHEXString.h"
#import "PPHTTPRequest.h"
#import "XWUserManager.h"
#include "BuglyHotfixConfuse_pch.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CXWPlaceholderView.h"
#endif

#pragma mark ---推送
//JPush
#define PUSH_JGPUSH_APPKEY @"05f7c428c5eec2b387bc2470"
#define PUBLISH_CHANNEL @"App Store"
#define AppKey @"1100530100"


#pragma mark ---占位图
#define KCXWPublicPic   @"CXWPlaceImage"  //普通站位图



#pragma mark  --定位城市
#define LocationCity     @"LocationCity" //定位城市
#define CXWHistroyCity   @"CXWHistroyCity"



#pragma mark ---屏幕尺寸
// 屏幕尺寸
#define KAPPWidth ([UIScreen mainScreen].bounds.size.width)
#define KAppHeight ([UIScreen mainScreen].bounds.size.height)
#define KAPPSCREENSCALE   [UIScreen mainScreen].scale

//状态栏的高度
#define CURRENTSCREN_STATUSHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
 //TabBar高度
#define CURRENTSCREN_TABBARHEIGHT (KAppHeight >= 812.0 ? 83 : 49)
#define CURRENTSCREN_NAVBAR_HEIGHT (KAppHeight >= 812.0 ? 88 : 64)
#define CURRENTSCREN_SafeArea_HEIGHT (KAppHeight >= 812.0 ? 34 : 0)
#define CURRENTSCREN_Status_HEIGHT (KAppHeight >= 812.0 ? 44 : 20)


#define kIs_iPhoneX (KAppHeight >= 812.0)


#define SCREEN_SCALE   ([UIScreen mainScreen].scale)
#define ONE_PIXEL      (1.0f/SCREEN_SCALE)
//系统比例尺寸
#define KWidth_BI ((1/375.0)*[UIScreen mainScreen].bounds.size.width)
#define KHeight_BI ((1/667.0)*[UIScreen mainScreen].bounds.size.height)


#pragma mark 系统设置
#define KAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define KAPPUserDefaultes ((NSUserDefaults *)[NSUserDefaults standardUserDefaults])
// 获取设备唯一标识符
#define IPHONEDEVICEUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]



#pragma mark 系统颜色
// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#pragma mark 空判断
//字符串是否为空  空是yes
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



#pragma mark 打印信息
#ifdef DEBUG

#define CXWLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define CXWLog(...)

#endif

#pragma mark 多线程
#define CXWdispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define CXWdispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#endif /* Header_h */
