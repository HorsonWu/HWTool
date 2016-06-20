//
//  UIViewController+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface UIViewController (HW)
-(void)showProgressView:(UIView *)view customView:(UIView *)customView progressHUDMode:(MBProgressHUDMode)mode bgColor:(UIColor *)color;

-(void)hideProgressView:(UIView *)view;
-(void)createBackButton;
@end
