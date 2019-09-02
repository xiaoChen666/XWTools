//
//  PPInterfacedConst.m
//  PPNetworkHelper
//
//  Created by YiAi on 2017/7/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPInterfacedConst.h"

#pragma mark  ======URLBASE=====

#if ProductSever
/*!正式服务器*/
NSString *const URL_BASE = @"https://api.babygarden.org.cn";
#elif TestSever
/*!测试服务器*/
NSString *const URL_BASE = @"https://beta-api.babygarden.org.cn:446";
#elif LocalSever
/*!本地服务器*/
NSString *const URL_BASE = @"http://192.168.1.253";
#endif

#pragma mark =====测试接口======
///测试post
NSString *const URL_PostTestAPi = @"/api/Customer/CrosTest3";

#pragma mark  ======接口详情=====

#pragma mark  ======新成长测评功能控制器======
///获取验证码(异步)
 NSString *const URL_GTSystemGetCheckCodeGT = @"api/GTSystem/GetCheckCodeGT";
///注册新客户
NSString *const URL_GTSystemRegisterGT = @"api/GTSystem/RegisterGT";
///app登录
NSString *const URL_GTSystemLoginGT = @"api/GTSystem/LoginGT";
///保存用户第一次基本信息
NSString *const URL_GTSystemUploadCustImageAndInfoGT = @"api/GTSystem/UploadCustImageAndInfoGT";
///重置密码
NSString *const URL_GTSystemResetPassword = @"api/GTSystem/ResetPassword";
///获取新版成长记录首页宝宝信息
NSString *const URL_GTSystemGetGrowTestHomeInfo = @"api/GTSystem/GetGrowTestHomeInfo";
///上传宝宝信息
NSString *const URL_GTSystemUploadBabyImageAndInfoGT = @"api/GTSystem/UploadBabyImageAndInfoGT";
///获取系统字典信息选项
NSString *const URL_GTSystemGetSubSysDictItemListGT = @"api/GTSystem/GetSubSysDictItemListGT";
///单保存新版成长测评用户头像
NSString *const URL_GTSystemUploadCustImageForEditGT = @"api/GTSystem/UploadCustImageForEditGT";
///修改用户信息 ReqKeyName:1昵称,2性别
NSString *const URL_GTSystemSettingCustInfoGT = @"api/GTSystem/SettingCustInfoGT";
///获取我的宝宝记录详情
NSString *const URL_GTSystemGetMyBabyDetail = @"api/GTSystem/GetMyBabyDetail";


///获取育儿通文章列表
NSString *const URL_GTSystemGetGTArticleList = @"api/GTSystem/GetGTArticleList";

///获取育儿通顶部图片
NSString *const URL_GTSystemGetGTArticleCoverImages = @"api/GTSystem/GetGTArticleCoverImages";
///获取育儿通文章详情
NSString *const URL_GTSystemGetGTArticleDetail = @"api/GTSystem/GetGTArticleDetail";
///提交文章关注
NSString *const URL_GTSystemPostArticleCollection = @"api/GTSystem/PostArticleCollection";
///获取育儿通文章标签
NSString *const URL_GTSystemGetGTArticleTagList = @"api/GTSystem/GetGTArticleTagList";

///检查待注册的手机号是否重复。true通过，false重复
NSString *const URL_GTSystemGetRegisterChecking = @"api/GTSystem/RegisterChecking";

#pragma mark  ======成长测评控制器======

///开始测评
NSString *const URL_GrowTestGrowTestStart = @"api/GrowTest/GrowTestStart";
///继续做题
NSString *const URL_GrowTestGrowTestContinue = @"api/GrowTest/GrowTestContinue";
///获取测评报告详情
 NSString *const URL_GrowTestGetBabyTestReportDetail = @"api/GrowTest/GetBabyTestReportDetail";
///获取我的历史测评记录
NSString *const URL_GrowTestGetBabyTestRecordList = @"api/GrowTest/GetBabyTestRecordList";
///获取宝宝能力发展总结文本
NSString *const URL_GrowTestGetBabyAbilityAnalysis = @"api/GrowTest/GetBabyAbilityAnalysis";
///获取宝宝五大领域发展商结论
NSString *const URL_GrowTestGetBabyQuotientAnalysis = @"api/GrowTest/GetBabyQuotientAnalysis";


#pragma mark  ======系统参数======
///获取系统参数项
NSString *const URL_SystemGetSystemContent = @"api/System/GetSystemContent";
///获取新闻详情
NSString *const URL_SystemGetSysNewsDetail = @"/api/System/GetSysNewsDetail";
