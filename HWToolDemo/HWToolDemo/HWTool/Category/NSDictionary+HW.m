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

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        
        return nil;
    }
    
    return dic;
}

@end
