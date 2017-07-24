//
//  HWNetwork.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWNetwork.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@implementation HWNetwork
+ (instancetype)manager {
    
    static HWNetwork * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HWNetwork alloc]init];
    });
    return manager;
}
+ (BOOL)isNetworkEnabled {
    
    BOOL isEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    isEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (isEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        isEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
        //        NSLog(@"判断网络状态：%d",isEnabled ?YES:NO);
    }
    
    return isEnabled;
}

+ (HWNetStatus)currentNetStatus {
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
    NSString * currentRadioAccessTechnology = info.currentRadioAccessTechnology;
    if (currentRadioAccessTechnology) {
        if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
            return HWNetStatus4G;
        }
        else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
            return HWNetStatus2G;
        }
        else {
            return HWNetStatus3G;
        }
    }
    NSLog(@"无法识别当前网络类型");
    return HWNetStatus3G;
}


+ (HWNetOperator)currentNetOperator {
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = info.subscriberCellularProvider;
    switch (carrier.mobileNetworkCode.intValue) {
        case 0:
            return HWNetOperatorChinaMobile;
            break;
        case 1:
            return HWNetOperatorChinaUnicom;
            break;
        case 2:
            return HWNetOperatorChinaMobile;
            break;
        case 3:
            return HWNetOperatorChinaTelecom;
            break;
        case 5:
            return HWNetOperatorChinaTelecom;
            break;
        case 6:
            return HWNetOperatorChinaUnicom;
            break;
        case 7:
            return HWNetOperatorChinaMobile;
            break;
        default:
            NSLog(@"无法识别当前运营商类型");
            return HWNetOperatorChinaMobile;
            break;
    }
}

@end
