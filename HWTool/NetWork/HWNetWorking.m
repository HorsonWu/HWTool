//
//  HWNetWorking.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWNetWorking.h"

@implementation HWNetWorking

+ (instancetype)sharedClient {
    HWNetWorking *_sharedClient = [[HWNetWorking alloc] initWithBaseURL:[NSURL URLWithString:URL_API_BASE]];
    _sharedClient.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [_sharedClient.requestSerializer setValue:[UserConfig shareConfig].token forHTTPHeaderField:UserToken];
    _sharedClient.requestSerializer.timeoutInterval = 8.0;//请求8秒超时
    return _sharedClient;
}

+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                     completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
        }
    }];
}

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                      completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
        }
    }];
}

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
        }
    }];
}

+ (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                     completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] PUT:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
            
        }
    }];
}

+ (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                       completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] PATCH:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
        }
    }];
}

+ (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                        completion:(void (^)(BOOL isSuccess, id responseObject, NSString *errorMessage))completion {
    
    return [[HWNetWorking sharedClient] DELETE:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(YES, responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            //            completion(NO, nil, operation.responseObject[@"error"]);
            completion(NO, nil, @"网络开小差了");
        }
    }];
}

-(void)api_download:(id)url filePath:(NSString *)path
              block:(void (^)(NSArray *posts, NSError *error))block{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block([NSArray arrayWithObjects:path, nil], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    [operation start];
    
}
@end
