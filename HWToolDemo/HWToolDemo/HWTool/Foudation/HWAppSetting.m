//
//  HWAppSetting.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWAppSetting.h"

@implementation HWAppSetting
+ (BOOL)getBool:(NSString *)key {
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    return [userDef boolForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key {
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setBool:value forKey:key];
    [userDef synchronize];
}


+ (NSString *)getValue:(NSString *)key
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    return [userDef objectForKey:key];
}

+ (void)setValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:value forKey:key];
    [userDef synchronize];
}

@end
