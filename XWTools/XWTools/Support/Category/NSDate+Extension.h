//
//  NSDate+Extension.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

///获取今天的日期字符串
+ (NSString *)cxwGetCurrentDateStr;
///获取日期根据字符串
+ (NSDate *)cxw_getDateWithStr:(NSString*)dateStr;


///返回没有转换成世界时间的日期字符串
+ (NSDate *)CXWGetDateNoWorldHourWithStr:(NSString *)dateStr;

///返回年月日的日期
+ (NSDate *)cxw_backYMDDatwWithStr:(NSString *)dateStr;

///和当前日期比 是否超过今天
+ (BOOL)CompareTodayDateWithDate:(NSDate *)Date;

///获取下一天
+ (NSDate *)CXWGetNextDate:(NSDate *)date;
///获取上一天
+ (NSDate *)CXWGetLastDate:(NSDate *)date;

///把日期转换成年月日的字符串
+ (NSString *)CXWBackDateStrWithDate:(NSDate *)date;
#pragma mark  ======陈叙文======
///返回当前时间字符串根据当前时间
+ (NSString *)backNowDateStr ;

//获取这个月今天的数据
+ (NSString *)backCurrentMonthDayStr;

///根据字符串返回日期
+ (NSDate *)backDateWithStr:(NSString *)datestr;

///根据网络请求的数据返回可以统一接受的日期字符串
+ (NSString *)CXWBackPublicDateStrWithNetStr:(NSString *)netStr;

///得到一个月多少天
+ (NSInteger)howmanyDaysWithYear:(NSInteger)year AndMonth:(NSInteger)month;

///获取一个月的第一天是星期几
+ (NSInteger)GetWeekDayWithYear:(NSInteger)year AndMonth:(NSInteger)month;

///获取年 根据日期字符串
+ (NSInteger)GetYearWithDateStr:(NSString *)dateStr;

///获取月 根据日期字符串
+ (NSInteger)GetMonthWithDateStr:(NSString *)dateStr;

///获取日 根据日期字符串
+ (NSInteger)GetDayWithDateStr:(NSString *)dateStr;


+ (NSInteger)GetCurrentYear;

+ (NSInteger)GetCurrentMonth;

+ (NSInteger)GetCurrentDay;

+ (NSInteger)GetCurrentHourWithDate:(NSDate *)date;

+ (NSInteger)GetCurrentMinuteWithDate:(NSDate *)date;;

///检测月份有没有超过当前月份
+ (BOOL)CheckMonthIsBigThanCurrentDate:(NSString*)dateStr;
///检测日期有没有超过当前月份
+ (BOOL)CheckDayIsBigThanCurrentDate:(NSString*)dateStr;

///是否是相同的年月
+ (BOOL)isSameYearAndMonthWithFirstDate:(NSString *)firstDateStr AndLastDateStr:(NSString *)lastDateStr ;

///根据月份的字符串返回可执行网络请求的字符串
+ (NSString *)backDateStrWithSourceStr:(NSString*)dateStr;

+ (NSString *)backLastDayStrWithSourStr:(NSString *)dateStr;
@end
