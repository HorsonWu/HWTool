//
//  HWJsonStringTool.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWJsonStringTool : NSObject
/**
 *  字典转String
 */
+ (NSString*)dictionaryToJsonStr:(NSDictionary *)dic;

/**
 *  String转Json
 */
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonStr;
/*
 * 将字典数组转换为JSON数组
 */
+ (NSString *)dictionaryArrayToJsonArray:(NSArray<NSDictionary *> *)dicArray;
@end
