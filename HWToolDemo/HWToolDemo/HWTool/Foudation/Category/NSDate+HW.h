//
//  NSDate+HW.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/21.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HW)
/**
 *  获取当前时间
 */
+ (NSDate *)localDate;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


/*
 日期-字符串转换函数
 */
//年月日转换：2015-10-30
+ (NSString *)stringFromDateYMD:(NSDate *)date;
+ (NSDate *)dateFromStringYMD:(NSString *)dateString;

//年月日星期时分：2015-10-30 星期四 10:20
+ (NSString *)stringFromDateYMDEHM:(NSDate *)date;
+ (NSDate *)dateFromStringYMDEHM:(NSString *)dateString;

//年月日时分秒：2015-10-30 10:10:10
+ (NSString *)stringFromDateYMDHMS:(NSDate *)date;
+ (NSDate *)dateFromStringYMDHMS:(NSString *)dateString;

//获取年、月、日
+ (NSString *)getYear:(NSDate *)date;
+ (NSString *)getMonth:(NSDate *)date;
+ (NSString *)getDay:(NSDate *)date;

@end
