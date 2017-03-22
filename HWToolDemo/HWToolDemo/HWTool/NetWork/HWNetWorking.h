//
//  HWNetworking.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^handleBlock)(BOOL isSucc, id responseObject, NSError * error);
typedef void (^progressBlock)(float progress);

@interface HWNetworking : NSObject

/**
 *  获取新的实例
 *  注意：每次网络请求都应该使用新的实例
 */
+ (instancetype)manager;

/**
 *  设置请求头
 */
- (void)setValue:(id)value forHTTPHeaderField:(NSString *)field;

/**
 *  GET
 */
- (void)GET:(NSString *)URLString handle:(handleBlock)handle;

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters handle:(handleBlock)handle;

- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(progressBlock)progress handler:(handleBlock)handle;

/**
 *  POST
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters handle:(handleBlock)handle;

- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(progressBlock)progress handler:(handleBlock)handle;

- (void)POST:(NSString *)URLString jsonData:(NSData *)jsonData handle:(handleBlock)handle;

/*
 *  Request
 */
- (void)REQUEST:(NSURLRequest*)request progress:(progressBlock)progress handler:(handleBlock)handle;

/**
 *  PUT
 */
- (void)PUT:(NSString *)urlString parameters:(NSDictionary *)parameters data:(NSData *)data progress:(progressBlock)progress handler:(handleBlock)handle;
@end
