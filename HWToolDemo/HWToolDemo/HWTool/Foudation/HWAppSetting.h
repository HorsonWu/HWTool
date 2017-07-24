//
//  HWAppSetting.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAppSetting : NSObject

/*
 从UserDefault取值
 */
+ (BOOL)getBool:(NSString *)key;

/*
 存值到UserDefault
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

/*
 从UserDefault取值
 */
+ (NSString *)getValue:(NSString *)key;

/*
 存值到UserDefault
 */
+ (void)setValue:(id)value forKey:(NSString *)key;


@end
