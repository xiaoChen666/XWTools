//
//  CXWConst.h
//  CarRank
//
//  Created by 陈叙文 on 2018/4/14.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark =====图标类======

///导航栏返回按钮
UIKIT_EXTERN NSString *const naviBackImageStr;
///表格右边的箭头
UIKIT_EXTERN NSString *const cellRightArrowImageStr;

#pragma mark 提示信息

UIKIT_EXTERN NSString *const appScheme;

UIKIT_EXTERN NSString *const CXWPayNoti;

UIKIT_EXTERN NSString *const CXWHaveNoMoreData;

UIKIT_EXTERN NSString *const CXWNetWorkError;

///功能待开放
UIKIT_EXTERN NSString *const CXWWaitOpenStr;

#pragma mark ---AES加密宏定义
UIKIT_EXTERN NSString *const CXWSecret;

#pragma mark  字体颜色 和字体
UIKIT_EXTERN NSString *const CXWThemeColorStr;
UIKIT_EXTERN NSString *const CXWSupportColorStr;

UIKIT_EXTERN NSString *const CXWTestMaxHighColorStr;
UIKIT_EXTERN NSString *const CXWTestHighColorStr;
UIKIT_EXTERN NSString *const CXWTestMidColorStr;
UIKIT_EXTERN NSString *const CXWTestLowColorStr;


/**分割线颜色*/
UIKIT_EXTERN NSString *const CXWSeparatorLineColorStr;
///视图背景色
UIKIT_EXTERN NSString *const CXWVCBacKColorStr;
///视图背景色
UIKIT_EXTERN NSString *const CXWVCBacKColorStr;
///cell或者view的背景色
UIKIT_EXTERN NSString *const CXWWriteColorStr;

///网页链接颜色
UIKIT_EXTERN NSString *const CXWURLColorStr;


UIKIT_EXTERN NSString *const CXWPingFang_SC_Medium;
UIKIT_EXTERN NSString *const CXWPingFang_SC_Regular;
UIKIT_EXTERN NSString *const CXWPingFang_SC_Bold;
//苹果系统徽章值颜色
UIKIT_EXTERN NSString *const CXWSystemBadgeColor;

///看护曲线颜色
UIKIT_EXTERN NSString *const CXWCareBarColor;
///哭闹曲线颜色
UIKIT_EXTERN NSString *const CXWCryBarColor;

#pragma mark 登录相关
/**用户存储模型 */
UIKIT_EXTERN NSString *const CXWLoginModelKey;


#pragma mark =====Cell标识======
///cell标识
UIKIT_EXTERN NSString *const CXWCellIdentifier;

#pragma mark 圆角大小
/**圆角大小*/
UIKIT_EXTERN const CGFloat  CXWAvatarCornerRadius;




#pragma mark  ======特殊用户名=====
UIKIT_EXTERN NSString *const CXWSpecialUserID;



#pragma mark  ======取出指定code的系统参数值======

///关于我们
UIKIT_EXTERN NSString *const CXWGetSystemContentAboutUs;

///超级宝宝测评使用条款及隐私政策
UIKIT_EXTERN NSString *const CXWGetSystemNewGrowTestPolicy;

///怎么测评
UIKIT_EXTERN NSString *const CXWGetSystemNewGrowNGTRule;

#pragma mark  ======MQTT参数======
///MQTT 服务器地址
UIKIT_EXTERN NSString *const CXWMQTTHostName;

///MQTT 用户名
UIKIT_EXTERN NSString *const CXWMQTTUserName;

///MQTT 密码
UIKIT_EXTERN NSString *const CXWMQTTUserPassword;

///MQTT 异或算法密钥
UIKIT_EXTERN NSString *const CXWMQTTYihuoPassword;

#pragma mark  ======系统类======
/**版本key值 判断需不需要引导页*/
UIKIT_EXTERN NSString *const CXWBundleVersion;

///弹框动画时间
UIKIT_EXTERN NSTimeInterval const CXWAlertViewAnimalTime;

///是否弹出过测评须知的提示
UIKIT_EXTERN NSString *const CXWStartTestMustKnow;


#pragma mark  ======通知类======
///智能记录添加成长记录后更改日期并刷新页面
UIKIT_EXTERN NSString *const CXWChooseCenterGrowUpRecord;

UIKIT_EXTERN NSString *const CXWSecondClickGrowRecordNoti;

UIKIT_EXTERN NSString *const CXWRefreshDeviceListNoti;



