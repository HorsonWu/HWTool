//
//  HWJsonStringTool.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWJsonStringTool.h"

@implementation HWJsonStringTool
+ (NSString*)dictionaryToJsonStr:(NSDictionary *)dic {
    
    if (dic == nil) {
        
        return nil;
    }
    
    NSError * parseError;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if (parseError) {
        NSLog(@"%@",parseError);
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonStr {
    
    if (jsonStr == nil) {
        
        return nil;
    }
    
    NSError * parseError;
    
    NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&parseError];
    
    if (parseError)  {
        NSLog(@"%@",parseError);
        return nil;
    }
    
    return dict;
}
@end
