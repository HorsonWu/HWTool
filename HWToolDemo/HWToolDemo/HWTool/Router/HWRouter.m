//
//  HWRouter.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWRouter.h"

NSString * const WZRouterParameterURL = @"WZRouterParameterURL";
NSString * const WZRouterParameterCompletion = @"WZRouterParameterCompletion";
NSString * const WZRouterParameterUserInfo = @"WZRouterParameterUserInfo";
NSString * const WZRouterParameterBlock = @"WZRouterParameterBlock";
NSString * const WZRouterWildcard = @"~";

@interface HWRouter ()

/*
 保存所有已注册的URL,结构如下:
 例如保存的URL为:
 add:@"/user/:userId/"
 add:@"/story/:storyId/"
 add:@"/user/:userId/story/?a=0"
 那么routes就是下面这样
 {
 story =     {
 ":storyId" =         {
 "_" = "<__NSMallocBlock__: 0x608000252120>";
 };
 };
 user =     {
 ":userId" =         {
 "_" = "<__NSGlobalBlock__: 0x107ffe680>";
 story =             {
 "_" = "<__NSMallocBlock__: 0x608000252120>";
 };
 };
 };
 }
 */
@property (nonatomic, strong) NSMutableDictionary *routes;

@end

@implementation HWRouter

+ (instancetype)shared {
    static HWRouter * router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[HWRouter alloc]init];
    });
    return router;
}

+ (void)registerURL:(NSString *)URL toHandle:(WZRouterHandle)handle {
    [[self shared]addURL:URL andHandle:handle];
}

+ (void)deRegisterURL:(NSString *)URL {
    [[self shared]removeURL:URL];
}

+ (void)openURL:(NSString *)URL {
    [self openURL:URL completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id))completion {
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id))completion {
    //转utf-8
    URL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //解析URL中的参数
    NSMutableDictionary * parameters = [[self shared]generateParametersForURL:URL];
    //转回来
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByRemovingPercentEncoding];
        }
    }];
    //
    if (parameters) {
        if (completion) {
            parameters[WZRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[WZRouterParameterUserInfo] = userInfo;
        }
        //执行回调
        WZRouterHandle handle = parameters[WZRouterParameterBlock];
        if (handle) {
            [parameters removeObjectForKey:WZRouterParameterBlock];
            handle(parameters);
        }
    }
}

+ (BOOL)canOpenURL:(NSString *)URL {
    return [[self shared]generateParametersForURL:URL] ? YES : NO;
}

#pragma mark - 处理URL
//添加路由规则到routes
- (void)addURL:(NSString*)URL andHandle:(WZRouterHandle)handle {
    NSMutableDictionary * subRoute = [self addURL:URL];
    if (handle && subRoute) {
        subRoute[@"_"] = handle;
    }
}

- (NSMutableDictionary*)addURL:(NSString*)URL {
    //分解URL
    NSArray * components = [self componentsForURL:URL];
    //路由总表
    NSMutableDictionary * route = self.routes;
    //
    for (NSString * component in components) {
        //遍历到最后，添加该规则
        if (![route objectForKey:component]) {
            route[component] = [NSMutableDictionary dictionary];
        }
        route = [route objectForKey:component];
    }
    //返回最后一级的路由规则
    return route;
}

//提取URL的元素
- (NSArray*)componentsForURL:(NSString*)URL {
    //
    NSMutableArray * components = [NSMutableArray array];
    //如果包含"://"
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        NSArray * segments = [URL componentsSeparatedByString:@"://"];
        [components addObject:segments[0]];
        // 如果只有协议，那么放一个占位符
        URL = segments.lastObject;
        if (!URL.length) {
            [components addObject:WZRouterWildcard];
        }
    }
    //转为URL提取元素，排除"/"和"?"
    for (NSString * component in [[NSURL URLWithString:URL]pathComponents]) {
        //分隔符不要
        if ([component isEqualToString:@"/"]) {
            continue;
        }
        //?后面的查询参数不要
        if ([[component substringToIndex:1]isEqualToString:@"?"]) {
            break;
        }
        [components addObject:component];
    }
    return components;
}

//从routes查找路由规则并生成Handle的Parameters
/*
 如果匹配成功，那么生成的参数字典结构如下:
 比返回的parameters多了一个 WZRouterParameterBlock = "<__NSMallocBlock__: 0x608000252120>";
 */
- (NSMutableDictionary*)generateParametersForURL:(NSString*)URL {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    //源URL
    parameters[WZRouterParameterURL] = URL;
    //查找路由规则
    NSMutableDictionary * route = self.routes;
    NSArray * components = [self componentsForURL:URL];
    BOOL found = NO;
    for (NSString * component in components) {
        // 对 key 进行排序，这样可以把 ~ 放到最后
        NSArray * routeKeys = [route.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        //
        for (NSString * key in routeKeys) {
            //如果有对应的key或者查找到最后的通配符，说明已经找到
            if ([key isEqualToString:component] || [key isEqualToString:WZRouterWildcard]) {
                found = YES;
                route = route[key];
                break;
            }
            //如果key是可变节点，则将URL的可变值提取出来
            else if ([key hasPrefix:@":"]) {
                found = YES;
                route = route[key];
                //将component赋值到对应的key，暂时不处理特殊字符情况 如 id.html
                parameters[[key substringFromIndex:1]] = component;
                break;
            }
        }
        // 如果没有找到该component 对应的 handler，则以上一层的 handler 作为 fallback
        if (!found && !route[@"_"]) {
            return nil;
        }
    }
    //提取规则
    if (route[@"_"]) {
        parameters[WZRouterParameterBlock] = [route[@"_"]copy];
    }
    //解析查询参数
    NSArray<NSURLQueryItem*> * queryItems = [[NSURLComponents alloc]initWithURL:[NSURL URLWithString:URL] resolvingAgainstBaseURL:NO].queryItems;
    for (NSURLQueryItem * item in queryItems) {
        parameters[item.name] = item.value;
    }
    //
    return parameters;
}

//从routes删除路由规则
- (void)removeURL:(NSString*)URL {
    NSMutableArray * components = [self componentsForURL:URL].mutableCopy;
    //只删除最后一级路由规则
    if (components.count > 1) {
        // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
        NSString * componentsPath = [components componentsJoinedByString:@"."];
        NSMutableDictionary * route = [self.routes valueForKeyPath:componentsPath];
        //如果该route存在,则记录最后一级的key，返回上一级将其删除
        if (route.count > 1) {
            NSString * lastComponent = components.lastObject;
            [components removeLastObject];
            // 有可能是根 key，这样就是 self.routes 了
            route = self.routes;
            if (components.count) {
                NSString * componentsPathWithoutLast = [components componentsJoinedByString:@"."];
                route = [self.routes valueForKeyPath:componentsPathWithoutLast];
            }
            [route removeObjectForKey:lastComponent];
        }
    }
}


#pragma mark - Util
- (NSMutableDictionary *)routes {
    if (!_routes) {
        _routes = [NSMutableDictionary dictionary];
    }
    return _routes;
}


@end
