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

@end
