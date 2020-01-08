//
//  Event.h
//  UMSAgent
/**
 * Cobub Razor
 *
 * An open source analytics iphone sdk for mobile applications
 *
 * @package		Cobub Razor
 * @author		WBTECH Dev Team
 * @copyright	Copyright (c) 2011 - 2012, NanJing Western Bridge Co.,Ltd.
 * @license		http://www.cobub.com/products/cobub-razor/license
 * @link		http://www.cobub.com/products/cobub-razor/
 * @since		Version 0.1
 * @filesource
 */

#import <Foundation/Foundation.h>

@interface Event : NSObject<NSCoding>


@property (nonatomic,copy) NSString *action; // 测试事件id
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString *refer;//app表示的是上一个页面title
@property (nonatomic,copy) NSString *event_type;///exposure/click/pageview
@property (nonatomic,copy) NSString *event_value; //事件值
@property (nonatomic,copy) NSString *algorithm;//哪种算法推荐的, 暂时为空
@property (nonatomic,copy) NSString *deviceid;
@property (nonatomic,copy) NSString *os_version;///ios12
@property (nonatomic,copy) NSString *resolution;///1920x1080/分辨率"
@property (nonatomic, assign) NSInteger duration; //持续时间
@property (nonatomic,copy) NSString *platform;///ios
@property (nonatomic,copy) NSString *country;///国家
@property (nonatomic,copy) NSString *region;///地区
@property (nonatomic,copy) NSString *city;///城市
@property (nonatomic,copy) NSString *time;  // 时间时间
@property (nonatomic,copy) NSString *userid;///用户id
@property (nonatomic,copy) NSString *app_version;///app版本
@property (nonatomic,copy) NSString *channel;///渠道
@property (nonatomic,copy) NSString *type;///点击的具体类型
@property (nonatomic,copy) NSString *brand;//手机品牌 apple
@property (nonatomic,copy) NSString *other_info;/// {“扩充字段”}   







@end
