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

/*
 * 将字典数组转换为JSON数组
 */
+ (NSString *)dictionaryArrayToJsonArray:(NSArray<NSDictionary *> *)dicArray {
    //1. 初始化可变字符串，存放最终生成json字串
    NSMutableString * jsonString = [[NSMutableString alloc]initWithString:@"["];
    //2. 遍历数组，取出键值对并按json格式存放
    for (NSDictionary * dict in dicArray) {
        
        NSString * dictJson = [NSString stringWithFormat:@"%@,",[HWJsonStringTool dictionaryToJsonStr:dict]];
        [jsonString appendString:dictJson];
    }
    // 3. 获取末尾逗号所在位置
    NSRange range = NSMakeRange(jsonString.length - 1, 1);
    // 4. 将末尾逗号换成结束的]
    [jsonString replaceCharactersInRange:range withString:@"]"];
    return jsonString;
}
@end
