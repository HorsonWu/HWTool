//
//  HWNetworking.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWNetworking.h"
#import "NSString+HWNet.h"
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGET,
    RequestTypePOST
};
@interface HWNetworking()<NSURLSessionDataDelegate>

@property (nonatomic, copy) handleBlock handle; //任务完成的回调
@property (nonatomic, copy) progressBlock progress; //下载进度回调

@property (nonatomic, strong) NSMutableURLRequest * request;       //请求对象
@property (nonatomic, strong) NSMutableDictionary * requestHeader; //请求头
@property (nonatomic, strong) NSURLSession * session;              //会话对象
@property (nonatomic, strong) NSURLSessionDataTask * task;         //任务
@property (nonatomic, strong) NSURLSessionUploadTask * uploadTask; //上传任务
@property (nonatomic, strong) NSURLResponse * response;            //服务器响应
@property (nonatomic, strong) NSMutableData * responseData;        //接收数据

@end

@implementation HWNetworking

#pragma mark -

+ (instancetype)manager {
    return [[self alloc]init];
}

#pragma mark -
/**
 *  GET
 */
- (void)GET:(NSString *)URLString handle:(handleBlock)handle {
    [self dataTaskWithUrl:URLString type:RequestTypeGET parameters:nil handle:^(BOOL isSucc, id responseObject, NSError *error) {
        if (handle) handle(isSucc, responseObject, error);
    }];
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters handle:(handleBlock)handle {
    [self dataTaskWithUrl:URLString type:RequestTypeGET parameters:parameters handle:^(BOOL isSucc, id responseObject, NSError *error) {
        if (handle) handle(isSucc, responseObject, error);
    }];
}

- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(progressBlock)progress handler:(handleBlock)handle {
    [self dataTaskWithUrl:urlString type:RequestTypeGET parameters:parameters progress:progress handle:handle];
}

/**
 *  POST
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters handle:(handleBlock)handle {
    [self dataTaskWithUrl:URLString type:RequestTypePOST parameters:parameters handle:^(BOOL isSucc, id responseObject, NSError *error) {
        if (handle) handle(isSucc, responseObject, error);
    }];
}

- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters progress:(progressBlock)progress handler:(handleBlock)handle {
    [self dataTaskWithUrl:urlString type:RequestTypePOST parameters:parameters progress:progress handle:handle];
}

- (void)POST:(NSString *)URLString jsonData:(NSData *)jsonData handle:(handleBlock)handle {
    self.progress = nil;
    self.handle = handle;
    self.request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [self.request setHTTPMethod:@"POST"];
    //设置请求头
    if (self.requestHeader != nil) {
        [self.requestHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.request setValue:obj forHTTPHeaderField:key];
        }];
    }
    [self.request setHTTPBody:jsonData];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:self.request];
    [self.task resume];
}

/*
 *  Request
 */
- (void)REQUEST:(NSURLRequest*)request progress:(progressBlock)progress handler:(handleBlock)handle {
    self.progress = progress;
    self.handle = handle;
    self.request = request.mutableCopy;
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:self.request];
    [self.task resume];
}


/**
 *  PUT
 */
- (void)PUT:(NSString *)urlString parameters:(NSDictionary *)parameters data:(NSData *)data progress:(progressBlock)progress handler:(handleBlock)handle {
    self.progress = progress;
    self.handle = handle;
    self.request = [self requetWithUrl:urlString type:RequestTypePOST parameters:parameters];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.uploadTask = [self.session uploadTaskWithRequest:self.request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary * dict = error == nil ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] : nil;
        if (handle) handle(error == nil ? YES : NO, dict, error);
    }];
    [self.uploadTask resume];
}

#pragma mark -
/**
 *  设置请求头
 */
- (void)setValue:(id)value forHTTPHeaderField:(NSString *)field {
    if (self.requestHeader == nil) self.requestHeader = [NSMutableDictionary dictionary];
    [self.requestHeader setValue:value forKey:field];
}

/**
 *  设置响应接收的类型
 */
- (void)setupAcceptType {
    [self.request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.request addValue:@"text/json"        forHTTPHeaderField:@"Accept"];
    [self.request addValue:@"text/javascript"  forHTTPHeaderField:@"Accept"];
    [self.request addValue:@"text/html"        forHTTPHeaderField:@"Accept"];
}

#pragma mark -
/**
 *  网络请求核心方法（无代理）
 */
- (void)dataTaskWithUrl:(NSString *)urlString
                   type:(RequestType)type
             parameters:(NSDictionary *)parameters
                 handle:(handleBlock)handle {
    
    self.request = [self requetWithUrl:urlString type:type parameters:parameters];
    self.session = [NSURLSession sharedSession];
    self.task = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //error无值说明请求成功
        NSDictionary * dict = error == nil ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] : nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handle) handle(error == nil ? YES : NO, dict, error);
        });
        WEAKSELF
        [weakSelf releaseSession];
    }];
    [self.task resume];
}

/**
 *  网络请求核心方法（使用代理）
 */
- (void)dataTaskWithUrl:(NSString *)urlString
                   type:(RequestType)type
             parameters:(NSDictionary *)parameters
               progress:(progressBlock)progress
                 handle:(handleBlock)handle {
    
    self.progress = progress;
    self.handle = handle;
    self.request = [self requetWithUrl:urlString type:type parameters:parameters];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:self.request];
    [self.task resume];
}


/**
 *  生成请求对象
 */
- (NSMutableURLRequest *)requetWithUrl:(NSString *)urlString type:(RequestType)type parameters:(NSDictionary *)parameters {
    NSMutableURLRequest * request;
    switch (type) {
        case RequestTypeGET:
        {
            if (parameters != nil && parameters.allKeys.count > 0) {
                NSMutableString * completeUrlString = [NSMutableString stringWithFormat:@"%@?",urlString];
                [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [completeUrlString appendFormat:@"%@=%@&",key,obj];
                }];
                request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[completeUrlString removeLastLetter]]];
            }else{
                request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            }
        }
            break;
        case RequestTypePOST:
        {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            //设置请求体
            if (parameters != nil && parameters.allKeys.count > 0) {
                NSMutableString * bodyString = [NSMutableString stringWithString:@""];
                [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [bodyString appendFormat:@"%@=%@&",key,obj];
                }];
                [request setHTTPBody:[[bodyString removeLastLetter] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
            break;
        default:
            break;
    }
    //设置请求头
    if (self.requestHeader != nil) {
        [self.requestHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    //设置超时时间
    [request setTimeoutInterval:10.0];
    
    return request;
}


#pragma mark -
//服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    /* 默认是取消的
     NSURLSessionResponseCancel = 0, 默认的处理方式，取消
     NSURLSessionResponseAllow = 1, 接收服务器返回的数据
     */
    self.response = response;
    completionHandler(NSURLSessionResponseAllow);
}

//服务器返回数据 可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    if (self.responseData == nil) self.responseData = [NSMutableData data];
    [self.responseData appendData:data];
    if (self.progress) self.progress(self.responseData.length / (float)self.response.expectedContentLength);
}

//请求完成会调用该方法，请求失败则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (self.handle) self.handle(error == nil ? YES : NO, self.responseData, error);
    [self releaseSession];
}

//文件上传进度 可能会调用多次
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    if (self.progress) self.progress(totalBytesSent/(float)totalBytesExpectedToSend);
}

//Https双向认证
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSString *method = challenge.protectionSpace.authenticationMethod;
    if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        return;
    }
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
    SecIdentityRef identity;
    
    // 读取p12证书中的内容
    OSStatus result = [self extractP12Data:inPKCS12Data toIdentity:&identity];
    if(result != errSecSuccess){
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        return;
    }
    SecCertificateRef certificate = NULL;
    SecIdentityCopyCertificate (identity, &certificate);
    const void *certs[] = {certificate};
    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray) persistence:NSURLCredentialPersistencePermanent];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}

-(OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("app2015");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    if (options) {
        CFRelease(options);
    }
    return securityError;
}


#pragma mark -
- (void)releaseSession {
    [self.session invalidateAndCancel];
    [self.session resetWithCompletionHandler:^{
        NSLog(@"release session complete");
    }];
}

@end
