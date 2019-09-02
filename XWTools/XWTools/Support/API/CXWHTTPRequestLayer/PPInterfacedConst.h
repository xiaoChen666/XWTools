
//
//  PPInterfacedConst.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>
/*

将项目中所有的接口写在这里,方便统一管理,降低耦合

这里通过宏定义来切换你当前的服务器类型,
将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
如下:现在的状态为测试服务器
这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
*/
//#define ProductSever 0
//#define TestSever    1
//#define LocalSever 0

/** 接口前缀-正式服务器服务器*/
UIKIT_EXTERN NSString *const URL_BASE;
#pragma mark  ======接口详情=====

#pragma mark =====测试接口======
///测试post
UIKIT_EXTERN NSString *const URL_PostTestAPi;


#pragma mark  ======新成长测评功能控制器======
///获取验证码(异步)
UIKIT_EXTERN NSString *const URL_GTSystemGetCheckCodeGT;
///注册新客户
UIKIT_EXTERN NSString *const URL_GTSystemRegisterGT;
///app登录
UIKIT_EXTERN NSString *const URL_GTSystemLoginGT;
///保存用户第一次基本信息
UIKIT_EXTERN NSString *const URL_GTSystemUploadCustImageAndInfoGT;
///重置密码
UIKIT_EXTERN NSString *const URL_GTSystemResetPassword;
///获取新版成长记录首页宝宝信息
UIKIT_EXTERN NSString *const URL_GTSystemGetGrowTestHomeInfo;
///上传宝宝信息
UIKIT_EXTERN NSString *const URL_GTSystemUploadBabyImageAndInfoGT;
///获取系统字典信息选项
UIKIT_EXTERN NSString *const URL_GTSystemGetSubSysDictItemListGT;
///单保存新版成长测评用户头像
UIKIT_EXTERN NSString *const URL_GTSystemUploadCustImageForEditGT;
///修改用户信息 ReqKeyName:1昵称,2性别
UIKIT_EXTERN NSString *const URL_GTSystemSettingCustInfoGT;
///获取我的宝宝记录详情
UIKIT_EXTERN NSString *const URL_GTSystemGetMyBabyDetail;

///获取育儿通文章列表
UIKIT_EXTERN NSString *const URL_GTSystemGetGTArticleList;

///获取育儿通顶部图片
UIKIT_EXTERN NSString *const URL_GTSystemGetGTArticleCoverImages;
///获取育儿通文章详情
UIKIT_EXTERN NSString *const URL_GTSystemGetGTArticleDetail;
///提交文章关注
UIKIT_EXTERN NSString *const URL_GTSystemPostArticleCollection;
///获取育儿通文章标签
UIKIT_EXTERN NSString *const URL_GTSystemGetGTArticleTagList;


///检查待注册的手机号是否重复。true通过，false重复
UIKIT_EXTERN NSString *const URL_GTSystemGetRegisterChecking;


#pragma mark  ======成长测评控制器======
///开始测评
UIKIT_EXTERN NSString *const URL_GrowTestGrowTestStart;
///继续做题
UIKIT_EXTERN NSString *const URL_GrowTestGrowTestContinue;
///获取测评报告详情
UIKIT_EXTERN NSString *const URL_GrowTestGetBabyTestReportDetail;
///获取我的历史测评记录
UIKIT_EXTERN NSString *const URL_GrowTestGetBabyTestRecordList;
///获取宝宝能力发展总结文本
UIKIT_EXTERN NSString *const URL_GrowTestGetBabyAbilityAnalysis;
///获取宝宝五大领域发展商结论
UIKIT_EXTERN NSString *const URL_GrowTestGetBabyQuotientAnalysis;


#pragma mark  ======系统参数======
///获取系统参数项
UIKIT_EXTERN NSString *const URL_SystemGetSystemContent;

///获取新闻详情
UIKIT_EXTERN NSString *const URL_SystemGetSysNewsDetail;
