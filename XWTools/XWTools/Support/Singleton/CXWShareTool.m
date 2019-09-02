//
//  CXWShareTool.m
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import "CXWShareTool.h"
#import "AFNetworking.h"

#import <UShareUI/UMSocialUIManager.h>

@interface CXWShareTool()<UMSocialShareMenuViewDelegate>
@property (nonatomic, strong) UIViewController *VC;
@end
@implementation CXWShareTool
#pragma mark --单例
static CXWShareTool* _defaultTool = nil;
+(instancetype) defaultTool
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _defaultTool = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _defaultTool ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [CXWShareTool defaultTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [CXWShareTool defaultTool] ;
}

#pragma mark 分享

/** 普通分享*/
- (void)CXWSharePicWithDic:(NSDictionary*)para WithVC:(UIViewController*)VC
{
    self.VC = VC;
    [self KPCXWShareClickWithVC:self.VC WithDic:para];
}

- (void)CXWShareVideoWithDic:(NSDictionary *)para WithVC:(UIViewController *)VC {
    self.VC = VC;
    [self KPCXWShareClickWithVC:self.VC WithDic:para];
}


-(void)KPCXWShareClickWithVC:(UIViewController*)VC WithDic:(NSDictionary*)result {

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine)
                                               ]];
    //设置分享面板的显示和隐藏的代理回调
    
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
    @weakify(self);
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        CXWLog(@"---%ld----%@",platformType,userInfo);
        
        //在回调里面获得点击的
        if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
            //            NSLog(@"点击演示添加Icon后该做的操作");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
                                                                message:@"具体操作方法请参考UShareUI内接口文档"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
                [alert show];
                
            });
        }
        else{
            [[CXWShareTool defaultTool] StartShareWithType:platformType WithVC:weak_self.VC WithDic:result];
        }
    }];
    
}



- (void)StartShareWithType:(UMSocialPlatformType)platformType WithVC:(UIViewController*)VC WithDic:(NSDictionary*)result
{

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (result[@"title"])
    {
        NSString *imageStr  = result[@"image"];
        NSString  *title = result[@"title"];
        NSString *descr = result[@"content"];
        NSString *webpageUrl = result[@"url"];
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:imageStr];
        //设置网页地址
        shareObject.webpageUrl = webpageUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    else if (result[@"webpageUrl"]){
        UMShareWebpageObject *video = [UMShareWebpageObject shareObjectWithTitle:@"超级宝宝测评" descr:result[@"content"] thumImage:result[@"image"]];
        video.webpageUrl = result[@"webpageUrl"];
        messageObject.shareObject = video;
    }else{
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        NSString *imageSTr = result[@"image"];
        shareObject.shareImage = imageSTr ;
        messageObject.shareObject = shareObject;
    }
    //调用分享接口
    @weakify(self);
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:weak_self.VC completion:^(id data, NSError *error) {
        if (error) {
            CXWLog(@"----%@",error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [[CXWShareTool defaultTool] alertWithError:error];
    }];
    
    
}
- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    
    if (error.code ==2009)
    {
        result = @"您取消了分享";
    }
    else
    {
        result = @"分享失败";
    }
    
    if (!error)
    {
        result = @"分享成功";
    }
    //    NSLocalizedString(@"sure", @"朕知道了")
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"朕知道了"
                                          otherButtonTitles:nil];
    [alert show];
}

/**
 *  分享面板显示的回调
 */
- (void)UMSocialShareMenuViewDidAppear {
    
}

/**
 *  分享面板的消失的回调
 */
- (void)UMSocialShareMenuViewDidDisappear {
    
}

@end
