//
//  NSDictionary+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HW)
/*
 * 从字典取值，并转化成字符串
 * nil和null值判断，返回空字符串
 */
- (id)getObjectFromTheKey:(id)key;


/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
