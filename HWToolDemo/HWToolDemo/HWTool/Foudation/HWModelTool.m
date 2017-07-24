//
//  HWModelTool.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWModelTool.h"

@implementation HWModelTool
//输出model类，直接copy过去用
+ (void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName {
    
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        printf("@property (nonatomic,copy) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
}

@end
