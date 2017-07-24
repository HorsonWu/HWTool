//
//  UIViewController+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HW)
#pragma mark -- 设置导航栏颜色和导航栏的字体颜色
-(void)setThemeWithBarColor:(UIColor *)barColor fontColor:(UIColor *)fontColor;
#pragma mark -- 设置Tiltle
-(void)setTitle:(NSString*)titleName;
#pragma mark -- 自定义返回按钮（文字）
-(void)setBackButtonWithText:(NSString *)backText;
#pragma mark -- 自定义返回按钮（图片）
-(void)setBackButtonWithImage:(UIImage *)image;
#pragma mark -- 自定义导航栏左按钮（图片）
- (void)setNavLeftItemWithImage:(UIImage *)image selector:(SEL)selector;
#pragma mark -- 自定义导航栏左按钮（文字）
- (void)setNavLeftItemWithTitle:(NSString *)title selector:(SEL)selector;
#pragma mark -- 自定义导航栏右按钮（图片）
- (void)setNavRightItemWithImage:(UIImage *)image selector:(SEL)selector;
#pragma mark -- 自定义导航栏右按钮（文字）
- (void)setNavRightItemWithTitle:(NSString *)title selector:(SEL)selector;
@end
