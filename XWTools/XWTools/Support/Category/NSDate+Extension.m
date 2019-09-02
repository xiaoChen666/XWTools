//
//  NSDate+Extension.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}




+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return ret;
}
+ (NSString *)cxwGetCurrentDateStr {
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *currentDateStr = [format stringFromDate:currentDate];
    return currentDateStr;
}

+ (NSDate *)cxw_getDateWithStr:(NSString*)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];

    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return [self worldTimeToChinaTime:date];
}

+ (NSDate *)CXWGetDateNoWorldHourWithStr:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSDate *)cxw_backYMDDatwWithStr:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (BOOL)CompareTodayDateWithDate:(NSDate *)Date {
    NSTimeInterval secs = [Date timeIntervalSinceDate:[NSDate date]];
    if (secs>0) {
        return NO;
    }
    return YES;
}

///获取下一天
+ (NSDate *)CXWGetNextDate:(NSDate *)date {
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    return tomorrow;
}
///获取上一天
+ (NSDate *)CXWGetLastDate:(NSDate *)date {
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    return yesterday;
}

+ (NSString *)CXWBackDateStrWithDate:(NSDate *)date {
    date = [NSDate getNowDateFromatAnDate:date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd";
    
    NSString *string = [format stringFromDate:date];
    
    return string;
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

#pragma mark  ======陈叙文======
///返回当前时间字符串根据当前时间
+ (NSString *)backNowDateStr  {
    NSDate *date = [NSDate date];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *string = [format stringFromDate:date];
    
    return string;
}

+ (NSString *)backCurrentMonthDayStr {
    NSDate *date = [NSDate date];
    date = [NSDate getNowDateFromatAnDate:date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd";
    
    NSString *string = [format stringFromDate:date];
    
    return string;
}


+(NSDate *)backDateWithStr:(NSString *)datestr {
    
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm";
//    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *date = [format dateFromString:datestr];
    
    return date;
}

///根据网络请求的数据返回可以统一接受的日期字符串
+ (NSString *)CXWBackPublicDateStrWithNetStr:(NSString *)netStr {
    NSString *resultStr = [netStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    return resultStr;
}

+ (NSInteger)howmanyDaysWithYear:(NSInteger)year AndMonth:(NSInteger)month {

    
    NSDate * date = [NSDate CXWBackDateWithYear:year AndMonth:month];
    
   NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    

    return range.length;
}

+ (NSDate *)CXWBackDateWithYear:(NSInteger)year AndMonth:(NSInteger)month {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM"]; // 年-月
    
    NSString * dateStr = [NSString stringWithFormat:@"%ld-%02ld",year,month];
    
    NSDate * date = [formatter dateFromString:dateStr];
    return date;
}


+ (NSInteger)GetWeekDayWithYear:(NSInteger)year AndMonth:(NSInteger)month {

    
    NSDate * date = [NSDate CXWBackDateWithYear:year AndMonth:month];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekday = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    
    return weekday-1;
}

///获取年 根据日期字符串
+ (NSInteger)GetYearWithDateStr:(NSString *)dateStr {

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    
    
    return [self GetCurrentYearWithDate:MyDate];
}

///获取月 根据日期字符串
+ (NSInteger)GetMonthWithDateStr:(NSString *)dateStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    return [self GetCurrentMonthWithDate:MyDate];
}

///获取日 根据日期字符串
+ (NSInteger)GetDayWithDateStr:(NSString *)dateStr {

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    
    return [self GetCurrentDayWithDate:MyDate];
}

+ (NSInteger)GetCurrentYear {
    return [self GetCurrentYearWithDate:[NSDate date]];
}

+ (NSInteger)GetCurrentMonth {

    return [self GetCurrentMonthWithDate:[NSDate date]];
}

+ (NSInteger)GetDaysWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger day=[components day];
    
    return day;
}


+ (NSInteger)GetCurrentDay {

    
    return [self GetCurrentDayWithDate:[NSDate date]];
}

+ (NSInteger)GetCurrentYearWithDate:(NSDate *)date {
    NSDate  *currentDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger minute =[components year];
    
    return minute;
}

+ (NSInteger)GetCurrentMonthWithDate:(NSDate *)date {
    NSDate  *currentDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger minute =[components month];
    
    return minute;
}

+ (NSInteger)GetCurrentDayWithDate:(NSDate *)date {
    NSDate  *currentDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger minute =[components day];
    
    return minute;
}

+ (NSInteger)GetCurrentHourWithDate:(NSDate *)date {
    NSDate  *currentDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger hour =[components hour];
    
    return hour;
}

+ (NSInteger)GetCurrentMinuteWithDate:(NSDate *)date {
    NSDate  *currentDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger minute =[components minute];
    
    return minute;
}


+ (BOOL)CheckMonthIsBigThanCurrentDate:(NSString*)dateStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    
    
    NSInteger Year = [NSDate GetCurrentYearWithDate:MyDate];
    NSInteger Month = [NSDate GetCurrentMonthWithDate:MyDate];
    
    NSInteger currentYear = [NSDate GetCurrentYear];
    NSInteger currentMonth = [NSDate GetCurrentMonth];
    
    if (Year>currentYear) {
        return YES;
    } else if (Year==currentYear) {
        if (Month>currentMonth) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)CheckDayIsBigThanCurrentDate:(NSString*)dateStr {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    
    
    
    
    NSInteger Year = [NSDate GetCurrentYearWithDate:MyDate];
    NSInteger Month = [NSDate GetCurrentMonthWithDate:MyDate];
    NSInteger day = [NSDate GetCurrentDayWithDate:MyDate];
    
    NSInteger currentYear = [NSDate GetCurrentYear];
    NSInteger currentMonth = [NSDate GetCurrentMonth];
    NSInteger currentDay = [NSDate GetCurrentDay];
    
    if (Year>currentYear) {
        return YES;
    } else if (Year==currentYear) {
        if (Month>currentMonth) {
            return YES;
        } else if (Month==currentMonth) {
            if (day>currentDay) {
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)isSameYearAndMonthWithFirstDate:(NSString *)firstDateStr AndLastDateStr:(NSString *)lastDateStr {

    
    NSInteger firstYear = [NSDate GetYearWithDateStr:firstDateStr];
    NSInteger firstMonth = [NSDate GetMonthWithDateStr:firstDateStr];
    
    NSInteger secondYear = [NSDate GetYearWithDateStr:lastDateStr];
    NSInteger secondMonth = [NSDate GetMonthWithDateStr:lastDateStr];
    
    if ((firstYear==secondYear)&&(firstMonth==secondMonth)) {
        return YES;
    }
    return NO;
    
}


+ (NSString *)backDateStrWithSourceStr:(NSString*)dateStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM";
    //    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // NSString * -> NSDate *
    NSDate *MyDate = [format dateFromString:dateStr];
    
    
    
    
    NSInteger Year = [NSDate GetCurrentYearWithDate:MyDate];
    NSInteger Month = [NSDate GetCurrentMonthWithDate:MyDate];
    
    NSInteger currentYear = [NSDate GetCurrentYear];
    NSInteger currentMonth = [NSDate GetCurrentMonth];
    
    if (Year==currentYear&&Month==currentMonth) {
        NSInteger currentDay = [NSDate GetCurrentDay];
        return [NSString stringWithFormat:@"%ld-%02ld-%02ld",currentYear,currentMonth,currentDay];
    } else {

        NSInteger maxDays = [NSDate howmanyDaysWithYear:Year AndMonth:Month];
        return [NSString stringWithFormat:@"%ld-%02ld-%02ld",Year,Month,maxDays];
    }
}

+ (NSString *)backLastDayStrWithSourStr:(NSString *)dateStr {
    dateStr = [dateStr stringByAppendingString:@" 23:30"];
    
    NSDate *currentDate = [NSDate backDateWithStr:dateStr];
    
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:currentDate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    NSString *lastDayStr = [format stringFromDate:lastDay];
    
    return lastDayStr;
}

@end
