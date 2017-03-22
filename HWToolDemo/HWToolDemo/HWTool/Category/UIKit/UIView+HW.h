//
//  UIView+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HW)
/*
 画像素为1的线
 */
+ (instancetype)drawVerticalLineWithFrame:(CGRect)frame;
+ (instancetype)drawHorizonLineWithFrame:(CGRect)frame;

///动画
- (void)startShakeAnimation;//摇动动画
- (void)stopShakeAnimation;
- (void)startRotateAnimation;//360°旋转动画
- (void)stopRotateAnimation;

///截图
- (UIImage *)screenshot;


///显示提示框

@end
