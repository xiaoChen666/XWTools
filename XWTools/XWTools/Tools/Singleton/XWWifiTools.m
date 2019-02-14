//
//  XWWifiTools.m
//  voiceAIApp
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "XWWifiTools.h"
#import "CXWDataManager.h"
@implementation XWWifiTools


#pragma mark --单例
static XWWifiTools* _shareTool = nil;

+(instancetype) shareTool {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shareTool = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _shareTool ;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    return [XWWifiTools shareTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone {
    return [XWWifiTools shareTool] ;
}

- (void)starListeningWiFiChange{
    //1.监听WiFi之间的切换
 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,onNotifyCallback,CFSTR("com.apple.system.config.network_change"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(APPDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //2.监听WiFi与4G等其他网络之间的切换
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
}

static void onNotifyCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSString* notifyName = (__bridge NSString *)name;//(NSString*)name;
    // WiFi之间的切换
    if ([notifyName isEqualToString:@"com.apple.system.config.network_change"]) {
        NSLog(@"i am listening networkChange:%@",notifyName);
        
    } else {
        NSLog(@"intercepted %@", notifyName);
    }
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus)
        {
            case NotReachable:
            {
                NSLog(@"《NotReachable》");
                break;
            }
                
            case ReachableViaWWAN:
            {
                self.wifiBssiD = nil;
                self.wifiSSID = nil;
                break;
            }
            case ReachableViaWiFi:
            {
                NSDictionary *netInfo = [[CXWDataManager shareManager] fetchNetInfo];
                self.wifiBssiD = [netInfo objectForKey:@"BSSID"];
                self.wifiSSID = [netInfo objectForKey:@"SSID"];
                break;
            }
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)APPDidBecomeActive {
    NSDictionary *netInfo = [[CXWDataManager shareManager] fetchNetInfo];
    self.wifiBssiD = [netInfo objectForKey:@"BSSID"];
    self.wifiSSID = [netInfo objectForKey:@"SSID"];
}

// 移除通知
- (void)stopListeningWiFiChange
{
    
}

- (void)startSSDP
{
    NSLog(@"《StartSSDP》");
}


@end
