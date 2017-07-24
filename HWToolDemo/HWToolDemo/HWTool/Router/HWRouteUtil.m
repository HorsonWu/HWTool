//
//  HWRouteUtil.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWRouteUtil.h"
#import "HWRouter.h"
@implementation HWRouteUtil
+ (instancetype)sharedUtil {
    static HWRouteUtil * util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[HWRouteUtil alloc]init];
    });
    return util;
}
+ (void)registerPages {
    
    //最好是创建一个头文件，将要路由的页面全部放在里面，然后直接调用头文件就好
    
    /*
    //消息种类列表
    [WZRouter registerURL:@"wz://message" toHandle:^(NSDictionary *routerParameters) {
        NewMessageCenterViewController *vc = [NewMessageCenterViewController new];
        [WZRouteUtil pushViewController:vc];
    }];
    //某种消息的消息列表
    [WZRouter registerURL:@"wz://message/list" toHandle:^(NSDictionary *routerParameters) {
        NewMessageListViewController *vc = [NewMessageListViewController new];
        if (routerParameters[WZRouterParameterUserInfo]) {
            NSDictionary *dic = routerParameters[WZRouterParameterUserInfo];
            vc.title = [dic getObjectFromKey:@"title"];
            vc.typeString = [dic getObjectFromKey:@"typeString"];
        }
        
        [WZRouteUtil pushViewController:vc];
    }];
     */
    
    
}


+ (void)goToPageWithUserInfo:(NSDictionary *)info {
    /*
    //消息中心
    [HWRouter openURL:@"wz://message"];
    //某种消息的消息列表
    [HWRouter openURL:@"wz://message/list" withUserInfo:@{@"title":@"标题",@"typeString":@"类型"} completion:nil];
     */
}

+ (BOOL)pushViewController:(UIViewController*)viewController {
    UINavigationController * nav = [HWRouteUtil currentNav];
    if (nav) {
        [nav pushViewController:viewController animated:YES];
        return YES;
    }
    return NO;
}

+ (BOOL)presentViewController:(UIViewController *)viewController {
    UINavigationController * nav = [HWRouteUtil currentNav];
    if (nav) {
        [[nav.viewControllers lastObject]presentViewController:viewController animated:YES completion:nil];
        return YES;
    }
    return NO;
}

+ (UINavigationController*)currentNav {
    UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbarVC = (UITabBarController*)rootVC;
        UINavigationController * nav = [tabbarVC.viewControllers objectAtIndex:tabbarVC.selectedIndex];
        return nav;
    }
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController*)rootVC;
    }
    return nil;
}

@end
