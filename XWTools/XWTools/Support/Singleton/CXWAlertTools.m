//
//  CXWAlertTools.m
//  voiceAIApp
//
//  Created by Avsnest on 2018/9/20.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWAlertTools.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
@implementation CXWAlertTools
static CXWAlertTools* _shareTools = nil;
+(instancetype)shareTools
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shareTools = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _shareTools;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [CXWAlertTools shareTools] ;
}

-(id)copyWithZone:(struct _NSZone *)zone
{
    return [CXWAlertTools shareTools] ;
}

- (void)CXWAlertTrueMessageWithTitle:(NSString *)title {
    
    [self CXWAlertWithTrueMessageWithTime:2 AndTitle:title];


}

- (void)CXWAlertErrorMessageWithTitle:(NSString *)title {
    [self CXWAlertWithErrorMessageWithTime:2 AndTitle:title];
}

- (void)CXWAlertWithTrueMessageWithTime:(NSTimeInterval)time AndTitle:(NSString*)title {
    UIImage *image = [UIImage imageNamed:@"voicecontrol_complete"];
    [self CXWAlertWithImage:image AndTitle:title AndTime:time AndView:[[CXWDataManager shareManager] lastTopWindow] AndBackColor:[[UIColor colorWithHexString:CXWThemeColorStr] colorWithAlphaComponent:0.5]];
}

- (void)CXWAlertWithErrorMessageWithTime:(NSTimeInterval)time AndTitle:(NSString*)title {
    
    UIImage *image = [UIImage imageNamed:@"voiceset_cancel"];
    
    [self CXWAlertWithImage:image AndTitle:title AndTime:time AndView:[[CXWDataManager shareManager] lastTopWindow] AndBackColor:[[UIColor colorWithHexString:CXWThemeColorStr] colorWithAlphaComponent:0.5]];
}



- (void)CXWAlertWithImage:(UIImage *)Image AndTitle:(NSString *)title AndTime:(NSTimeInterval)time AndView:(UIView *)alertView AndBackColor:(UIColor *)backColor {
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.imageSize = CGSizeMake(20, 20);
    style.messageNumberOfLines = 1;
    style.backgroundColor = backColor;
    style.messageFont = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:18];
    CXWdispatch_main_async_safe(^{
        [alertView makeToast:title duration:time position:CSToastPositionCenter title:nil  image:nil style:style completion:nil];
    });
    
}


@end
