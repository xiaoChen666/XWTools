//
//  XWWifiTools.h
//  voiceAIApp
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
//#import "OpenHABSSDPService.h"
@interface XWWifiTools : NSObject
+(instancetype) shareTool;//单例方法

// 监听WiFi变化相关的类
@property (nonatomic, strong) Reachability *hostReachability;

///WiFi的bssid
@property (nonatomic, copy) NSString *wifiBssiD;

@property (nonatomic, copy) NSString *wifiSSID;

- (void)starListeningWiFiChange;
@end
