//
//  UIWindow+HW.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/21.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "UIWindow+HW.h"

@implementation UIWindow (HW)


- (void)chooseRootViewControllerWithNewFeatureController:(UIViewController *)newFeatureVC homeController:(UIViewController *)homeVC {
    
    // 判断是否显示新特性
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [defaults objectForKey:@"CFBundleShortVersionString"];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion compare:localVersion] == NSOrderedDescending) {
        
        window.rootViewController = newFeatureVC;
        
        [defaults setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        [defaults synchronize];
    } else {
        window.rootViewController = homeVC;
    }
}
@end
