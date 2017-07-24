//
//  NSString+HWNet.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "NSString+HWNet.h"

@implementation NSString (HWNet)
- (NSString *)removeLastLetter {
    return [self substringToIndex:self.length - 1];
}
@end
