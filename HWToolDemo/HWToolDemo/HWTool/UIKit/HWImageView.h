//
//  HWImageView.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWImageView : NSObject
/*
 * 寻找1像素的线(可以用来隐藏导航栏下面的黑线）
 */
+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
