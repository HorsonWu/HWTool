//
//  NSDate+HW.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/21.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "NSDate+HW.h"
#define YMDFormat       @"YYYY-MM-dd"
#define YMDEHMFormat    @"YYYY-MM-dd EEE HH:mm"
#define YMDHMSFormat    @"YYYY-MM-dd HH:mm:ss"

static NSDateFormatter *s_formatterYMD = nil;
static NSDateFormatter *s_formatterYMDEHM = nil;
static NSDateFormatter *s_formatterYMDHMS = nil;
@implementation NSDate (HW)
/**
 *  获取当前时间
 */
+ (NSDate *)localDate {
    
    NSDate * datenow   = [NSDate date];
    NSTimeZone * zone  = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate * localeDate = [datenow dateByAddingTimeInterval:interval];
    
    return localeDate;
}

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2015-03-11
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2015-03-10
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}



+ (NSString *)stringFromDate:(NSDate *)date
                    formater:(NSDateFormatter * __strong *)formatter
                      format:(NSString *)format
{
    if (*formatter == nil) {
        *formatter = [[NSDateFormatter alloc] init];
        
        [*formatter setLocale:[NSLocale  currentLocale]];
        [*formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [*formatter setDateStyle:NSDateFormatterMediumStyle];
        [*formatter setTimeStyle:NSDateFormatterShortStyle];
        [*formatter setDateFormat:format];
    }
    
    return [*formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString
                  formater:(NSDateFormatter * __strong *)formatter
                    format:(NSString *)format
{
    if (dateString.length <= 0) {
        return [NSDate date];
    }
    if (*formatter == nil) {
        *formatter = [[NSDateFormatter alloc] init];
        
        [*formatter setLocale:[NSLocale  currentLocale]];
        [*formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [*formatter setDateStyle:NSDateFormatterMediumStyle];
        [*formatter setTimeStyle:NSDateFormatterShortStyle];
        [*formatter setDateFormat:format];
    }
    
    return [*formatter dateFromString:dateString];
}


+ (NSString *)stringFromDateYMD:(NSDate *)date
{
    return [NSDate stringFromDate:date formater:&s_formatterYMD format:YMDFormat];
}

+ (NSDate *)dateFromStringYMD:(NSString *)dateString
{
    return [NSDate dateFromString:dateString formater:&s_formatterYMD format:YMDFormat];
}

+ (NSString *)stringFromDateYMDEHM:(NSDate *)date
{
    return [NSDate stringFromDate:date formater:&s_formatterYMDEHM format:YMDEHMFormat];
}

+ (NSDate *)dateFromStringYMDEHM:(NSString *)dateString
{
    return [NSDate dateFromString:dateString formater:&s_formatterYMDEHM format:YMDEHMFormat];
}

+ (NSString *)stringFromDateYMDHMS:(NSDate *)date
{
    return [NSDate stringFromDate:date formater:&s_formatterYMDHMS format:YMDHMSFormat];
}

+ (NSDate *)dateFromStringYMDHMS:(NSString *)dateString
{
    return [NSDate dateFromString:dateString formater:&s_formatterYMDHMS format:YMDHMSFormat];
}

+ (NSString *)getYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = nil;
    
    /*
     // 年月日获得
     comps = [calendar components:NSYearCalendarUnit  | NSMonthCalendarUnit |
     NSDayCalendarUnit
     fromDate:date];
     */
    comps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSString *year = [NSString stringWithFormat:@"%@", @([comps year])];
    
    return year;
}

+ (NSString *)getMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitMonth fromDate:date];
    NSString *month = [NSString stringWithFormat:@"%@", @([comps month])];
    
    return month;
}

+ (NSString *)getDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:
             NSCalendarUnitDay fromDate:date];
    NSString *day = [NSString stringWithFormat:@"%@", @([comps day])];
    
    return day;
}


@end
