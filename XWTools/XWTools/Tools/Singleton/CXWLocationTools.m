//
//  CXWLocationTools.m
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import "CXWLocationTools.h"
#import <MapKit/MapKit.h> //地图框架
@interface CXWLocationTools ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (nonatomic, assign) BOOL haveLocation;
@end

@implementation CXWLocationTools

#pragma mark --单例
static CXWLocationTools* _defaultTool = nil;
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
    return [CXWLocationTools defaultTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [CXWLocationTools defaultTool] ;
}

#pragma mark
-(void)startLocationWithBlock:(LocationFinisnBlock)completion AndFailBlock:(LocationFailBlock)Fail{
    
    self.haveLocation = NO;
    
    if (completion) {
        _locationFinisnBlock = completion;
    }
    if (Fail)
    {
        _failBlock = Fail;
    }
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许

        self.locationManager = [[CLLocationManager alloc] init];

        self.locationManager.delegate = self;//遵循代理

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

        self.locationManager.distanceFilter = 1000.f;

        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）

        [self.locationManager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        if (_failBlock) {
            _failBlock();
        }
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
//    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
//    [manager stopUpdatingLocation];
    //根据经纬度反向地理编译出地址信息
    //en-HK,   zh-HK  en-HK, zh-Hans-HK, zh-HK
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文 zh-Hans-CN zh-Hans-HK
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans",nil]
                                              forKey:@"AppleLanguages"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = placemarks.firstObject;
        NSDictionary *address = [placemark addressDictionary];
        NSString *city = [address objectForKey:@"City"];
        NSString *SubLocality = [address objectForKey:@"SubLocality"];
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
        if (_failBlock) {
            _failBlock();
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        if (_failBlock) {
            _failBlock();
        }
    }
}
@end
