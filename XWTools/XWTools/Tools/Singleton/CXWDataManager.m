//
//  CXWDataManager.m
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import "CXWDataManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HSUpdateApp.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <sys/utsname.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+CXWStr.h"
@implementation CXWDataManager

#pragma mark --单例
static CXWDataManager* _dataManager = nil;
+(instancetype) shareManager {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _dataManager = [[super allocWithZone:NULL] init] ;
    }) ;
    return _dataManager ;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [CXWDataManager shareManager] ;
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [CXWDataManager shareManager] ;
}

#pragma mark  ======网络请求公共参数======
- (NSDictionary *)CXWBackPublicParameterWithSourceDic:(NSDictionary *)sourceDic {

    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:sourceDic];
    //如果字典不为空
    NSString *deviceMessage = [[CXWDataManager shareManager] deviceModelName];
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    [muDic setObject:[NSString stringWithFormat:@"%@\n%@",deviceMessage,sysVersion] forKey:@"modelNum"];
    [muDic setObject:@"1" forKey:@"infoSource"];
    return [muDic copy];
}

#pragma mark 系统类
/* 获取app版本 */
- (NSString*)getCurrentVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//返回最上层控制器
- (UIViewController *)currentViewController
{
    UIViewController* vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
- (UIView *)getParsentView:(UIView *)view{
    if ([[view nextResponder] isKindOfClass:[UIViewController class]] || view == nil) {
        return view;
    }
    return [self getParsentView:view.superview];
}
/* UIview类添加点击事件 */
- (void)addTapEventOnView:(UIView*)theView Target:(id)target Selecter:(SEL)selecter
{
    if (theView && [theView isKindOfClass:[UIView class]]) {
        
        theView.userInteractionEnabled = YES;
        [theView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:selecter]];
    }
}
- (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}


- (UIImageView *)getLineViewInNavigationBar:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark 文本高度类
//返回文本高度
- (CGFloat)getheightForString:(NSString *)str andWidth:(CGFloat)width andFont:(UIFont*)font {
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
    
}
//返回文本的宽度
- (CGFloat)getWidthForString:(NSString *)str andHeight:(CGFloat)height andFont:(UIFont*)font {
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

//获取富文本的高度
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithParagraph:(NSParagraphStyle*)paraStyle {
//
//        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
//                              };
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    //陈叙文 warning
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

#pragma mark 检测类
//是否纯数字
- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
//检验邮箱格式是否正确
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//检验手机号码是否正确
-(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11){
        return NO;
    }
    return YES;

}

//检验密码格式
- (BOOL)CheckPassword:(NSString *)password {
    if (password.length>=6) {
        return YES;
    }
    return NO;
}


- (BOOL) checkBankCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

- (void)AlertWithView:(UIView*)View WithTime:(CGFloat)time WithTitle:(NSString*)title
{
    
}

///获取最顶层的window IOS11 [[UIApplication sharedApplication].windows lastObject]获取最外层window是隐藏的
- (UIWindow *)lastTopWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    //逆序遍历 且window不能是隐藏的
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&!window.hidden)
            
            return window;
    }
    return [UIApplication sharedApplication].delegate.window;
}

- (NSDictionary *)fetchNetInfo
{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    //    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        //        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}


#pragma mark 转换类
//转json字符串
- (NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

///字符串转字典
- (NSDictionary *)toDicWithStr:(NSString *)sourStr {
    NSData *jsonData = [sourStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

-(UIImageView*)findlineviw:(UIView*)view{
    
    if ([view isKindOfClass:[UIImageView class]]&&view.bounds.size.height<=1.0) {
        return (UIImageView*) view;
    }for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self findlineviw:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
}

#pragma mark 网络状态
- (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}
#pragma mark  ======是否有网络=====
- (BOOL)CXWIsNetwork {
//    if ([YYReachability reachability].status==0) {
//        return NO;
//    }
    return YES;
}

#pragma mark 限制输入的长度
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)CXWisInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        NSString *other = @"➋➌➍➎➏➐➑➒";
        unsigned long len=str.length;
        for(int i=0;i<len;i++)
        {
            unichar a=[str characterAtIndex:i];
            if(!((isalpha(a))
                 ||(isalnum(a))
                 ||((a=='_') || (a == '-'))
                 ||((a >= 0x4e00 && a <= 0x9fa6))
                 ||([other rangeOfString:str].location != NSNotFound)
                 ))
                return NO;
        }
        return YES;
        
    }
    return isMatch;
}

/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
- (BOOL)CXWisInputRuleAndBlank:(NSString *)str {
    
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

/**
 *  过滤字符串中的emoji
 */
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

//限制最大输入长度
-(NSString *)getSubString:(NSString*)string WithMaXCount:(NSInteger)maxCount
{
    if (string.length > maxCount) {
        CXWLog(@"超出字数上限");
        
        return [string substringToIndex:maxCount];
    }else {
    }
    return nil;
}
//无符号分割字符串
- (NSArray*)CXWComponetStr:(NSString*)str
{
    
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    // 遍历字符串，按字符来遍历。每个字符将通过block参数中的substring传出
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        //
        [arr addObject:substring];
    }];
    return [arr copy];
}

#pragma mark 获取时间的上一个月和下一个月
- (NSString*)CXWGetTimeNextMonth:(NSString*)time IsNext:(BOOL)isNext
{
    
    NSDateFormatter *firstFormatter = [[NSDateFormatter alloc] init];
    [firstFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentStr = [NSString stringWithFormat:@"%@-15",time];
    
    NSDate *currentDate = [firstFormatter dateFromString:currentStr];
    
    NSString *dateStr = [self backNextORLastMonthWithDate:currentDate AndIsNext:isNext];
    return dateStr;
}

- (NSString*)backNextORLastMonthWithDate:(NSDate*)date AndIsNext:(BOOL)isNext
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:+1];
    if (!isNext)
    {
        [lastMonthComps setMonth:-1];
    }
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
//    CXWLog(@"date str = %@", dateStr);
    return dateStr;
}

#pragma mark 处理图片
- (UIImage*)imageWithCornerRadius:(CGFloat)radius Image:(UIImage*)image{
    
    CGRect rect = (CGRect){0.f,0.f,image.size};
    
    // void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //    scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    
    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    [image drawInRect:rect];
    
    //图片缩放，是非线程安全的
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


//修改图片尺寸 同比缩放
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    return newimage;
}

-(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark other
/* 隐藏多余表格 */
-(void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
/* 绘制圆角 */
- (void)setRoundCorner:(UIImageView*)imageView {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
}

#pragma mark  ======跳转到商店=====
- (void)CXWJumptoAppStore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1341567826?mt=8"]];
}
#pragma mark  ======检测新版本=====
- (void)CXWCheckNewVersionIsRankHomePage:(BOOL)isRankHomePage {
    
    if (![self cxw_checkisSameDate]) {
        return;
    }
    [HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        [self cxw_AlertSaveToday];

    }];
}

//检测本地是否存储了日期或者是否(超过了五个小时)
- (BOOL)cxw_checkisSameDate{

    NSDate *localDate = [KAPPUserDefaultes valueForKey:@"cxwsameDay"];
    if (kObjectIsEmpty(localDate)) {
        return YES;
    }
    return  [NSDate date].timeIntervalSince1970 - localDate.timeIntervalSince1970 > 60 * 60 * 5;
}
//在提示过后存储当天的字符串值
- (void)cxw_AlertSaveToday{
    [KAPPUserDefaultes setObject:[NSDate date] forKey:@"cxwsameDay"];
    [KAPPUserDefaultes synchronize];
}

#pragma mark  ======相机权限=====
- (BOOL)isCanUsePhotos {
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
    

}
- (void)CXWCannotUserPhotoAlertMessage{
    NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
    NSString *message = [NSString stringWithFormat:@"请在iPhone的”设置-隐私“选项中，允许%@使用你的摄像头",appName];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sure];
    UIViewController *currentVC = [[CXWDataManager shareManager] currentViewController];
    [currentVC presentViewController:alert animated:YES completion:nil];
    
}

-(NSData *)imageToData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024)
    {
        if (data.length>2*1024*1024)
        {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }
        else if (data.length>1024*1024)
        {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.2);
        }
        else if
            (data.length>512*1024)
        {
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }
    }
    return data;
}

- (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}

#pragma mark  ======是否是第一次显示======
- (BOOL)isFirstLaunch {
    NSString *versionKey = @"CXWBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    // 当前app的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    BOOL firstLaunch = NO;
    if (![lastVersion isEqualToString:currentVersion]) {
        firstLaunch = YES;
    }
    return firstLaunch;
}

#pragma mark  ======转换HTML======
///把网络请求回的HTML转换成字体大小可用的
- (NSString *)HtmlStrReplaceWithSourceStr:(NSString *)sourceStr {
    
    NSString *headStr = @"<meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes' />";
    NSString *newStr = [NSString stringWithFormat:@"<html><head>%@<title>欢迎您</title></head><body>%@</body></html>",headStr,sourceStr];
    return newStr;
}

#pragma mark  ======限制字符======
- (void)XWLimitTextFieldLengthWithTextFiled:(UITextField *)textField AndMaxLength:(NSInteger)maxLength {
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position){
        if (toBeString.length > maxLength){
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1){
                textField.text = [toBeString substringToIndex:maxLength];
//                [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:@"超过字数限制"];
            }
            else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)XWLimitTextViewLengthWithTextView:(UITextView *)textView AndMaxLength:(NSInteger)maxLength {
    NSString *toBeString = textView.text;
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                textView.text = [toBeString substringToIndex:maxLength];
//                [[CXWAlertTools shareTools] CXWAlertErrorMessageWithTitle:@"超过字数限制"];
            }
            else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

@end
