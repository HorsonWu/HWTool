//
//  HWNetWorking.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HWNetWorking : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;


+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                     completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                      completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;


+ (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                     completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;

+ (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                       completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;

+ (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                        completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion;

-(void)api_download:(id)url filePath:(NSString *)path
              block:(void (^)(NSArray *posts, NSError *error))block;
@end
