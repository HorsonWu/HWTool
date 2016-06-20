//
//  HWViewTool.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "NSObject+HW.h"

@interface HWViewTool : NSObject


/**
 * @breif                                 设置controller的NavigationTiltleView
 * @titleName                             标题
 * @imageName                             标题的图标
 * @controller                            控制器
 */
+(void)loadNavigationTiltleViewWithTitle:(NSString*)titleName  image:(NSString*)imageName forController:(UIViewController*)controller;

/**
 * @breif                                  生成导航栏返回按钮
 * @imageName                              图片名称
 * @viewController                         需要生成返回按钮的控制器
 */
+ (void)createNavBackItem:(NSString *)imageName andController:(UIViewController *)viewController;

/**
 * @breif                                   生成导航栏左按钮
 * @title                                   按钮的标题
 * @imageName                               图片名称
 * @viewController                          需要生成左按钮的控制器
 * @target                                  目标
 * @action                                  按钮的触发方法
 */
+ (void)createNavLeftButton:(NSString *)title WithImage:(NSString *)imageName WithController:(UIViewController *)viewController withTarget:(id)target withAction:(SEL)action;

/**
 * @breif                                   生成导航栏右按钮
 * @title                                   按钮的标题
 * @imageName                               按钮的背景图片名称
 * @viewController                          需要生成右按钮的控制器
 * @target                                  目标
 * @action                                  按钮的触发方法
 */
+ (void)createNavRightButton:(NSString *)title WithImage:(NSString *)imageName WithController:(UIViewController *)viewController withTarget:(id)target withAction:(SEL)action;



/**
 * @breif                                   传入label,根据label的内容，计算label的自适应高度
 * @label                                   要处理的label
 * @width                                   label的宽度
 */
+(void)getSizeByLabel:(UILabel*)label andTheLabelWidth:(int)width;

/**
 *	@brief                                  将方形图片转化为圆形的
 *  @image                                  图片本身
 *  @inset                                  开始画图片的位置
 *
 */
+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

/**
 *	@brief                                  将图片进行压缩
 *  @image                                  图片本身
 *  @inset                                  要压缩到的尺寸
 *
 */
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
/**
 *  改变图片的背景颜色
 *
 *  @param color 要改变成的颜色
 *  @param size  图片的大小
 *
 *  @return 修改好的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *	@brief                                  显示一个提示框
 *  @string                                 提示语
 *
 */
+(UIAlertView *)infoViewShowWithString:(NSString *)string;

/**
 *	@brief                                显示一个提示框,并在设置的时间后消失
 *  @message                              提示语
 *  @view                                 添加到的视图上
 *  @time                                 消失的间隔时间
 *
 */
+(void)showReminderMessage:(NSString *)message addToView:(UIView *)view hideAfterDelay:(NSTimeInterval)time;
@end
