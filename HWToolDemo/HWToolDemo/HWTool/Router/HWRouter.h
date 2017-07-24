//
//  HWRouter.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const WZRouterParameterURL;
extern NSString * const WZRouterParameterCompletion;
extern NSString * const WZRouterParameterUserInfo;

/*
 OpenURL的Handle
 routerParameters结构如下:
 {
 //调用回调
 WZRouterParameterCompletion = "<__NSGlobalBlock__: 0x107ffe680>";
 //源URL
 WZRouterParameterURL = "wz://onekey/eastdoor/?deviceid=2468298347";
 //路由参数
 WZRouterParameterUserInfo =     {
 "user_id" = 1900;
 };
 //路由可变变量:
 door = eastdoor;
 //查询参数
 deviceid = 2468298347;
 }
 */
typedef void(^WZRouterHandle)(NSDictionary *routerParameters);

/*
 打开URL时的completion
 */
typedef void(^WZRouterCompletion)(id result);

@interface HWRouter : NSObject
/**
 *  注册 URL 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  URL  如 wz://onekey/list
 */
+ (void)registerURL:(NSString*)URL toHandle:(WZRouterHandle)handle;

/**
 *  取消注册某个 URL
 */
+ (void)deRegisterURL:(NSString*)URL;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  URL      带 Scheme 的 URL，如 wz://onekey/list
 *  userInfo 附加参数
 *  completion URL 处理完成后的回调，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString*)URL;

+ (void)openURL:(NSString *)URL completion:(void(^)(id result))completion;

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary*)userInfo completion:(void(^)(id result))completion;

/**
 *  是否可以打开URL
 */
+ (BOOL)canOpenURL:(NSString*)URL;



@end
