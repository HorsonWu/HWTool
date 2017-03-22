//
//  UIColor+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HW)
/**
 * @breif                   获取颜色
 * @rgbValue                RGB的16进制色值
 * @alpha                   颜色的透明度（0到1）
 */
+(UIColor *)getColorFromRGB:(int)rgbValue alpha:(CGFloat)alpha;

/**
 * @breif                   获取颜色
 * @redValue                RGB的红色的色值
 * @greenValue              RGB的绿色的色值
 * @blueValue               RGB的蓝色的色值
 * @alpha                   颜色的透明度（0到1）
 */

+(UIColor *)getColorFromRGBRedValue:(CGFloat)redValue greenValue:(CGFloat)greenValue blueValue:(CGFloat)blueValue alpha:(CGFloat)alpha;

/*由16进制字符串获取颜色*/
+ (UIColor *)colorWithHexRGB:(NSString *)hexRGBString;
@end
