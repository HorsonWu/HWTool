//
//  HWNetwork.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
typedef NS_ENUM(NSInteger, HWNetStatus) {
    HWNetStatus2G = 2,
    HWNetStatus3G = 3,
    HWNetStatus4G = 4,
};

typedef NS_ENUM(NSInteger, HWNetType) {
    HWNetTypeNotReachable = 0,
    HWNetTypeWiFi = 1,
    HWNetTypeWWAN = 2,
};

typedef NS_ENUM(NSInteger, HWNetOperator) {
    HWNetOperatorChinaMobile = 1,
    HWNetOperatorChinaTelecom = 2,
    HWNetOperatorChinaUnicom = 3,
};
@interface HWNetwork : NSObject
+ (instancetype)manager;

+ (BOOL)isNetworkEnabled;

+ (HWNetStatus)currentNetStatus;

+ (HWNetOperator)currentNetOperator;
@end
