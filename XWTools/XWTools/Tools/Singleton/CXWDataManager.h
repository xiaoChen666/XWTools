//
//  CXWDataManager.h
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXWDataManager : NSObject

+ (instancetype) shareManager;//单例方法

#pragma mark  ======网络请求公共参数======
- (NSDictionary *)CXWBackPublicParameterWithSourceDic:(NSDictionary *)sourceDic;


#pragma mark 系统类
- (NSString*)getCurrentVersion;
- (UIViewController *)currentViewController;//返回最上层控制器
//获取控制器的View
- (UIView *)getParsentView:(UIView *)view;
- (void)addTapEventOnView:(UIView*)theView Target:(id)target Selecter:(SEL)selecter;
//判断当前控制器有没有显示（是否正在显示）
- (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

///获取导航栏下面的黑线
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view;

#pragma mark 文本高度类
//返回高度
- (CGFloat)getheightForString:(NSString *)str andWidth:(CGFloat)width andFont:(UIFont*)font;
//返回文本宽度
- (CGFloat)getWidthForString:(NSString *)str andHeight:(CGFloat)height andFont:(UIFont*)font;

//获取富文本的高度
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithParagraph:(NSParagraphStyle*)paraStyle;


#pragma mark 检测类
//是否纯数字
- (BOOL)isAllNum:(NSString *)string;

//检验邮箱格式
-(BOOL)isValidateEmail:(NSString *)email;

//检验手机格式是否正确
-(BOOL)isMobileNumber:(NSString *)mobileNum;

//检验密码格式
- (BOOL)CheckPassword:(NSString *)password;


//判断银行卡号
- (BOOL) checkBankCardNo:(NSString*) cardNo;


#pragma mark =====提示类======

- (UIWindow *)lastTopWindow;

#pragma mark 转换类
//转json字符串
- (NSString *)toJSONData:(id)theData;

///字符串转字典
- (NSDictionary *)toDicWithStr:(NSString *)sourStr;

-(UIImageView*)findlineviw:(UIView*)view;//获取导航栏下面的细线



#pragma mark 网络状态
- (NSString *)networkingStatesFromStatebar;

#pragma mark  ======是否有网络=====
- (BOOL)CXWIsNetwork;


#pragma mark 限制输入的长度
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)CXWisInputRuleNotBlank:(NSString *)str;
/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
- (BOOL)CXWisInputRuleAndBlank:(NSString *)str;

/**
 *  过滤字符串中的emoji
 */
- (NSString *)disable_emoji:(NSString *)text;

//限制最大输入长度
-(NSString *)getSubString:(NSString*)string WithMaXCount:(NSInteger)maxCount;

#pragma mark 分割字符串
- (NSArray*)CXWComponetStr:(NSString*)str;


#pragma mark 获取时间的上一个月和下一个月
- (NSString*)CXWGetTimeNextMonth:(NSString*)time IsNext:(BOOL)isNext;


#pragma mark 处理图片
- (UIImage*)imageWithCornerRadius:(CGFloat)radius Image:(UIImage*)image;

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;


#pragma mark other
- (void)setExtraCellLineHidden: (UITableView *)tableView;
- (void)setRoundCorner:(UIImageView*)imageView;


#pragma mark  ======跳转到商店=====
- (void)CXWJumptoAppStore;

#pragma mark  ======检测新版本=====
///检测新版本 是否在设置界面
- (void)CXWCheckNewVersionIsRankHomePage:(BOOL)isRankHomePage;

#pragma mark  ======相机权限=====
//是否有权限使用相机
- (BOOL)isCanUsePhotos;

//不能使用相机的时候提示语
- (void)CXWCannotUserPhotoAlertMessage;

//压缩图片
-(NSData *)imageToData:(UIImage *)myimage;

- (NSString*)deviceModelName;


- (NSDictionary *)fetchNetInfo;

#pragma mark  ======是否是第一次显示======
- (BOOL)isFirstLaunch;

#pragma mark  ======转换HTML======
///把网络请求回的HTML转换成字体大小可用的
- (NSString *)HtmlStrReplaceWithSourceStr:(NSString *)sourceStr;

#pragma mark  ======限制字符======

/**
 限制TextFiled的字符输入长度
 @param textField  传入的实例
 @param maxLength 最大长度
*/
- (void)XWLimitTextFieldLengthWithTextFiled:(UITextField *)textField AndMaxLength:(NSInteger)maxLength ;

/**
 限制textView的字符输入长度
 @param textView  传入的实例
 @param maxLength 最大长度
 */
- (void)XWLimitTextViewLengthWithTextView:(UITextView *)textView AndMaxLength:(NSInteger)maxLength;
@end
