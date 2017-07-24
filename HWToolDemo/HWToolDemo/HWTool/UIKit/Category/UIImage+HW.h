//
//  UIImage+HW.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HW)
/**
 *  加载图片
 *
 *  @param imageName 图片名
 *
 *  @return 适配系统的图片
 */
+ (instancetype)imageWithName:(NSString *)imageName;

/**
 *  返回一张自由拉伸的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)imageName;
+ (instancetype)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top;

/**
 *  获取view所对应的图片
 *
 *  @param view 目标view
 *
 *  @return image
 */
+ (instancetype)captureImageWithView:(UIView *)view;


/**
 *  圆形图片
 *
 *  @param name        待处理的图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 原型图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (UIImage *)createNewImageWithBg:(UIImage *)bgImage icon:(UIImage *)icon;
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 * 第一个参数string：二维码信息
 * 第二个参数imageSize:二维码的宽或者高
 * 第三个参数icon:需要添加到二维码上面的图片的名字
 * 第四个参数iconSize：需要添加到二维码上面的图片的size；
 */
+ (UIImage *)imageWithQRCodeImageMessage:(NSString *)string imageSize:(CGFloat)imageSize icon:(NSString *)icon iconSize:(CGSize)iconSize;


//图片拉伸、平铺接口
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;
//图片以ScaleToFit方式拉伸后的CGSize
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

//将图片转向调整为向上
- (UIImage *)fixOrientation;

//以ScaleToFit方式压缩图片
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;



/**
 *	@brief                                  将方形图片转化为圆形的
 *  @inset                                  开始画图片的位置
 *
 *  @return 修改好的图片
 */
-(UIImage*) circleWithParam:(CGFloat) inset;

/**
 *	@brief                                  将图片进行压缩
 *  @inset                                  要压缩到的尺寸
 *
 *  @return 修改好的图片
 */
-(UIImage*)imageScaledToSize:(CGSize)newSize;
/**
 *  改变图片的背景颜色
 *
 *  @param color 要改变成的颜色
 *  @param size  图片的大小
 *
 *  @return 修改好的图片
 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


@end
