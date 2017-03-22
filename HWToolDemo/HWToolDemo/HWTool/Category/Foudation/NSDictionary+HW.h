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
 * @brief 参数首字母通过ASCII做升序排列
 * 如a=1&b=2&c=3&d=4&g=5&h=6
 */

- (NSString*)sortedString;

@end
