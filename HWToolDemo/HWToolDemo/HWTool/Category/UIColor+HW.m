//
//  UIColor+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIColor+HW.h"

@implementation UIColor (HW)
+(UIColor *)getColorFromRGB:(int)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}
+(UIColor *)getColorFromRGBRedValue:(CGFloat)redValue greenValue:(CGFloat)greenValue blueValue:(CGFloat)blueValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:alpha];
}
@end
