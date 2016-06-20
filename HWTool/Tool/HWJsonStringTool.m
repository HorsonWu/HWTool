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
    
    NSError * parseError = nil;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if (parseError) NSLog(@"%@",parseError);
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonStr {
    
    NSError * parseError = nil;
    
    NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&parseError];
    
    if (parseError) NSLog(@"%@",parseError);
    
    return dict;
}
@end
