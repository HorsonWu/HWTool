//
//  UIWindow+HW.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/21.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (HW)
/*
 是否显示新特性页面
 */
- (void)chooseRootViewControllerWithNewFeatureController:(UIViewController *)loginVC homeController:(UIViewController *)homeVC;
@end
