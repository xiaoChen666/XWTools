//
//  CXWConst.m
//  CarRank
//
//  Created by 陈叙文 on 2018/4/14.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWConst.h"

#pragma mark =====图标类======
NSString *const naviBackImageStr = @"cxw_navi_back";

///表格右边的箭头
NSString *const cellRightArrowImageStr = @"";

#pragma mark 提示信息
NSString *const appScheme = @"CarRank";
NSString *const CXWPayNoti = @"CXWPayNotification";
NSString *const CXWHaveNoMoreData = @"别扯了，我可是有底线的";
NSString *const CXWNetWorkError = @"网络错误";
///功能待开放
NSString *const CXWWaitOpenStr = @"待开放..";

#pragma mark ---AES加密宏定义
NSString *const CXWSecret = @"params";

#pragma mark  字体颜色 和字体
NSString *const CXWThemeColorStr = @"#1F83FF";
NSString *const CXWSupportColorStr = @"#FFF99E";

NSString *const CXWTestMaxHighColorStr = @"#000000";
NSString *const CXWTestHighColorStr = @"#333333";
NSString *const CXWTestMidColorStr = @"#666666";
NSString *const CXWTestLowColorStr = @"#999999";

/**分割线颜色*/
NSString *const CXWSeparatorLineColorStr = @"#EDEDED";
//视图背景
NSString *const CXWVCBacKColorStr = @"#FFFFFF";

///cell或者view的背景色
NSString *const CXWWriteColorStr = @"#FFFFFF";
///网页链接颜色
NSString *const CXWURLColorStr = @"#3388ff";
//苹果系统徽章值颜色
NSString *const CXWSystemBadgeColor = @"#fb3d2d";

///SVIP导航栏的颜色值
NSString *const CXWSVIPNaviColorStr = @"#1D1D1F";


///看护曲线颜色
NSString *const CXWCareBarColor = @"#659cff";
///哭闹曲线颜色
NSString *const CXWCryBarColor = @"#ffb14f";

NSString *const CXWPingFang_SC_Medium = @"PingFangSC-Medium";
NSString *const CXWPingFang_SC_Regular = @"PingFang-SC-Regular";
NSString *const CXWPingFang_SC_Bold = @"PingFangSC-Semibold";


#pragma mark =====Cell标识======
///cell标识
NSString *const CXWCellIdentifier = @"CXWNormalIdentifer";

#pragma mark 登录相关
/**用户存储模型 */
NSString *const CXWLoginModelKey = @"CXWUsermessageKey";



#pragma mark 圆角大小
const CGFloat CXWAvatarCornerRadius = 5;

#pragma mark 上传APPCarsh
NSString *const CXWAPPError = @"CXWAPPError";



#pragma mark  ======取出指定code的系统参数值======


///关于我们
NSString *const CXWGetSystemContentAboutUs = @"AboutNewGrowTest";

///超级宝宝测评使用条款及隐私政策
NSString *const CXWGetSystemNewGrowTestPolicy = @"NewGrowTestPolicy";

///怎么测评
NSString *const CXWGetSystemNewGrowNGTRule = @"AboutNGTRule";

#pragma mark  ======MQTT参数======

///MQTT 服务器地址
NSString *const CXWMQTTHostName = @"39.108.160.202";

///MQTT 用户名
NSString *const CXWMQTTUserName = @"avsnest";

///MQTT 密码
NSString *const CXWMQTTUserPassword = @"avs12345";

///MQTT 异或算法密钥
NSString *const CXWMQTTYihuoPassword = @"1ddce2d43d5fe7b9e8629989cd3279b7";
#pragma mark  ======系统类======
/**版本key值 判断需不需要引导页*/
NSString *const CXWBundleVersion = @"CFBundleVersion";
///弹框动画时间
NSTimeInterval const CXWAlertViewAnimalTime = 0.3;

///是否弹出过测评须知的提示
NSString *const CXWStartTestMustKnow = @"CXWStartTestMustKnow";

#pragma mark  ======通知类======
///智能记录添加成长记录后更改日期并刷新页面
NSString *const CXWChooseCenterGrowUpRecord = @"CXWChooseCenterGrowUpRecord";
NSString *const CXWSecondClickGrowRecordNoti = @"CXWSecondClickGrowRecordNoti";
NSString *const CXWRefreshDeviceListNoti = @"CXWRefreshDeviceListNoti";



