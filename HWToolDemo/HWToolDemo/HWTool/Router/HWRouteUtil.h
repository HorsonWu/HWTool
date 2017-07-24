//
//  HWRouteUtil.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWRouteUtil : NSObject
+ (instancetype)sharedUtil;

/*
 * 注册各页面路由
 */
+ (void)registerPages;
/*
 * 根据不同类型路由到不同的页面
 */
+ (void)goToPageWithUserInfo:(NSDictionary *)info;
/*
 * 使用当前导航跳转页面
 */
+ (BOOL)pushViewController:(UIViewController*)viewController;
+ (BOOL)presentViewController:(UIViewController*)viewController;
/*
 * 返回当前的导航
 */
+ (UINavigationController*)currentNav;
@end
