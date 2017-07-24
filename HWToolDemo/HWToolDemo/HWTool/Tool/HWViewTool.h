//
//  HWViewTool.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HWViewTool : NSObject


/**
 * @breif                                   传入label,根据label的内容，计算label的自适应高度
 * @label                                   要处理的label
 * @width                                   label的宽度
 */
+(void)getSizeByLabel:(UILabel*)label andTheLabelWidth:(int)width;

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

/*
 * 获取当前控制器
 */
+ (UIViewController *)getCurrentVC;

//清理窗口的view
+ (void)cleanKeywindow;

@end
