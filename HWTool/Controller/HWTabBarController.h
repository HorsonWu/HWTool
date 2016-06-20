//
//  HWTabBarController.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTabbarView.h"
@interface HWTabBarController : UITabBarController
///自定义的tabBarView
@property (nonatomic, strong)HWTabbarView *tabBarView;
///传进tabBarController里面的viewController数组
@property (nonatomic, strong)NSArray *viewControllersArray;
///tabbar上未选中的图标数组
@property (nonatomic, strong)NSArray *normalImageArray;
///tabbar上选中的图标数组
@property (nonatomic, strong)NSArray *selectImageArray;
///tabbar上的文字标题数组
@property (nonatomic, strong)NSArray *tabbarTitleArray;



- (void)createControllers;
- (void)createView;
- (void)hiddenTabbar;
- (void)showTabbar;

@end
