//
//  NSDictionary+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "NSDictionary+HW.h"

@implementation NSDictionary (HW)
- (id)getObjectFromTheKey:(id)key {
    
    id obj = [self objectForKey:key];
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return obj;
}

- (NSString *)sortedString {
    //用系统方法compare做字母的简单排序
    NSArray *keys = [[self allKeys]sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in keys) {
        if ([[self valueForKey:key] class]) {
            
        }
        
        [result appendFormat:@"%@=%@&", key, [self valueForKey:key]];
    }
    return [result substringToIndex:result.length - 1];
}

@end
