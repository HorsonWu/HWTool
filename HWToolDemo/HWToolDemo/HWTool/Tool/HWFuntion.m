//
//  HWFuntion.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWFuntion.h"
#import "NSString+HW.h"
#import "HWCommonMocros.h"

#import "GTMBase64.h"
#include "HorsonIPAddress.h"

#import <CommonCrypto/CommonCrypto.h>
#import <AdSupport/AdSupport.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "netdb.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <objc/runtime.h>
@implementation HWFuntion
#pragma mark -- 获取时间戳（毫秒单位）
+(NSString *)getTimeStamp
{
    double secondTime=[[[NSDate alloc]init ]timeIntervalSince1970];
    double millisecondTime=secondTime*1000;
    NSString * millisecondTimeStr=[NSString stringWithFormat:@"%f",millisecondTime];
    NSRange pointRange=[millisecondTimeStr rangeOfString:@"."];
    NSString * MSTime=[millisecondTimeStr substringToIndex:pointRange.location];
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" time_stamp:%@",MSTime];
    HWLog(@"%@",systemlog);
    return MSTime;
}

#pragma mark -- 获取当前iOS操作系统版本号
+(float)getSystemVersion
{
    float  systemversion=[[[UIDevice currentDevice] systemVersion]floatValue];
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" system_version:%f",systemversion];
    HWLog(@"%@",systemlog);
   
    return systemversion;
}

#pragma mark -- 获取当前设备类型
+(NSString *)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceType = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return deviceType;
}
+(NSString *)getDeviceType
{
    NSString *deviceType = [self getDeviceVersion];
    //iPhone
    if ([deviceType isEqualToString:@"iPhone1,1"])
    {
        deviceType = @"iPhone";
    }
    else if ([deviceType isEqualToString:@"iPhone1,2"])
    {
        deviceType = @"iPhone_3G";
    }
    else if ([deviceType isEqualToString:@"iPhone2,1"])
    {
        deviceType = @"iPhone_3GS";
    }
    else if ([deviceType isEqualToString:@"iPhone3,1"])
    {
        deviceType = @"iPhone_4";
    }
    else if ([deviceType isEqualToString:@"iPhone4,1"])
    {
        deviceType = @"iPhone_4S";
    }
    else if ([deviceType isEqualToString:@"iPhone5,1"] || [deviceType isEqualToString:@"iPhone5,2"])
    {
        deviceType = @"iPhone_5";
    }
    else if ([deviceType isEqualToString:@"iPhone5,3"] || [deviceType isEqualToString:@"iPhone5,4"])
    {
        deviceType = @"iPhone_5C";
    }
    else if ([deviceType isEqualToString:@"iPhone6,1"] || [deviceType isEqualToString:@"iPhone6,2"])
    {
        deviceType = @"iPhone_5s";
    }
    else if ([deviceType isEqualToString:@"iPhone7,2"] )
    {
        deviceType = @"iPhone_6";
    }
    else if ([deviceType isEqualToString:@"iPhone7,1"] )
    {
        deviceType = @"iPhone_6+";
    }
    
    else if ([deviceType isEqualToString:@"iPod4,1"])
    {
        deviceType = @"iPod_touch_4";
    }
    else if ([deviceType isEqualToString:@"iPad3,2"])
    {
        deviceType = @"iPad_3_3G";
    }
    else if ([deviceType isEqualToString:@"iPad3,1"])
    {
        deviceType = @"iPad_3_WiFi";
    }
    else if ([deviceType isEqualToString:@"iPad2,2"])
    {
        deviceType = @"iPad_2_3G";
    }
    else if ([deviceType isEqualToString:@"iPad2,1"])
    {
        deviceType = @"iPad_2_WiFi";
    }
    else if ([deviceType isEqualToString:@"iPod5,1"])
    {
        deviceType = @"iPod_touch_5";
    }
    else if ([deviceType isEqualToString:@"iPad2,5"])
    {
        deviceType = @"iPod_Mini";
    }
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" deviceType:%@",deviceType];
    HWLog(@"%@",systemlog);
    return deviceType;
}

#pragma mark -- 获取MAC地址
+(NSString *)getMacaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL)
    {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    //	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
    //                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" mac:%@",[outstring uppercaseString]];
    HWLog(@"%@",systemlog);
    return [outstring uppercaseString];
}

#pragma mark -- 获取IDFA
+(NSString *)getIdfa
{
    NSString *idfaStr = nil;
    if ([self getSystemVersion]>= 6.0)
    {
#warning 要用到的时候打开
//        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else
    {
        idfaStr = @"";
    }
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" idfa:%@",idfaStr];
    HWLog(@"%@",systemlog);
    return idfaStr;
}

#pragma mark -- 获取UUID
+(NSString*) getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    HWLog(@"UUID:%@",result);
    return result;
}



#pragma mark -- 获取IP地址
+(NSString *)getIPAddress
{
    horsonInitAddresses () ;
    horsonGetIPAddresses () ;
    horsonGetHWAddresses () ;
    NSString * ip=[ NSString stringWithFormat:@"%s", ip_names[1]];
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" ip:%@",ip];
    HWLog(@"%@",systemlog);
    return ip;
}

#pragma mark -- 获取当前屏幕类型
+(HorsonScreenType)getCurrentScreenType
{
    
    //通过获取当前屏幕的较长边的长度，捕捉当前屏幕信息,获取正当的途径。
    float ScreenHeight=[UIScreen mainScreen].bounds.size.height;
    float ScreenWidth=[UIScreen mainScreen].bounds.size.width;
    
    float RealHeight=ScreenHeight>ScreenWidth?ScreenHeight:ScreenWidth;
    if (480==(int)RealHeight)
    {
        
        return HorsonScreenTypeWithInch3_5;
    }
    else if (568==(int)RealHeight)
    {
        
        return HorsonScreenTypeWithInch4_0;
    }
    else if (667==(int)RealHeight)
    {
        
        return HorsonScreenTypeWithInch4_7;
    }
    else if (640==(int)RealHeight || (int)736==RealHeight)
    {
        
        return HorsonScreenTypeWithInch5_5;
    }
    else if (1024==(int)RealHeight)
    {
        
        return HorsonScreenTypeWithIpadSize;
    }
    else
    {
        return HorsonScreenTypeWithSizeUnknow;
    }
}

#pragma mark -- 获取当前屏幕尺寸
+(CGRect)getCurrentScreenFrame
{
    CGRect currentScreenSize;
    if (IS_INTERFACE_THWARTWISE_IN)//如果是横屏幕的
    {
        switch ([self getCurrentScreenType])
        {
            case HorsonScreenTypeWithInch3_5:
                currentScreenSize=CGRectMake(0, 0, 480, 320);
                break;
            case HorsonScreenTypeWithInch4_0:
                currentScreenSize=CGRectMake(0, 0, 568, 320);
                break;
            case HorsonScreenTypeWithInch4_7:
                currentScreenSize=CGRectMake(0, 0, 667, 375);
                break;
            case HorsonScreenTypeWithInch5_5:
                currentScreenSize=CGRectMake(0, 0, 640, 360);
                break;
            case HorsonScreenTypeWithIpadSize:
                currentScreenSize=CGRectMake(0, 0, 1024, 768);
                break;
            default:
                currentScreenSize=CGRectMake(0, 0, 1024, 1024);
                break;
        }
    }
    else
    {
        switch ([self getCurrentScreenType])
        {
            case HorsonScreenTypeWithInch3_5:
                currentScreenSize=CGRectMake(0, 0, 320, 480);
                break;
            case HorsonScreenTypeWithInch4_0:
                currentScreenSize=CGRectMake(0, 0, 320, 568);
                break;
            case HorsonScreenTypeWithInch4_7:
                currentScreenSize=CGRectMake(0, 0, 375, 667);
                break;
            case HorsonScreenTypeWithInch5_5:
                currentScreenSize=CGRectMake(0, 0, 360, 640);
                break;
            case HorsonScreenTypeWithIpadSize:
                currentScreenSize=CGRectMake(0, 0, 768, 1024);
                break;
            default:
                currentScreenSize=CGRectMake(0, 0, 1024, 1024);
                break;
        }
    }
    //判断全打印
    NSString * systemlog=[NSString stringWithFormat:@" screen_frame:w%f_h%f",
                          currentScreenSize.size.width,currentScreenSize.size.height];
    HWLog(@"%@",systemlog);
    return currentScreenSize;
}

#pragma mark -- 判断当前网络状态,是否联网
+(BOOL)connectedToNetWork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        printf("Error.Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark -- 获取日期
+(NSString *)getTimeDate
{
    NSDate * nowDate=[NSDate date];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH:mm"];
    NSString *  locationString=[dateFormatter stringFromDate:nowDate];
    return locationString;
}

#pragma mark -- 获取项目配置信息
+(NSDictionary *)getProjectInfoPlist
{
    return [[NSBundle mainBundle]infoDictionary];
}


#pragma mark -- 获取键盘高度
+ (CGFloat)heightFromKeyboard
{
    CGFloat resultFloat = 0;
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    bool isUserInterFaceOrientationIsPortrait = UIInterfaceOrientationIsPortrait(currentOrientation);
    HorsonScreenType curScreenType = [HWFuntion getCurrentScreenType];
    if (curScreenType == HorsonScreenTypeWithIpadSize) {
        resultFloat = isUserInterFaceOrientationIsPortrait ? 264 : 352;
    } else if (curScreenType == HorsonScreenTypeWithInch5_5) {
        resultFloat = isUserInterFaceOrientationIsPortrait ? 365 : 270;
    } else if (curScreenType == HorsonScreenTypeWithInch4_7) {
        resultFloat = isUserInterFaceOrientationIsPortrait ? 254 : 188;
    } else if (curScreenType == HorsonScreenTypeWithInch4_0) {
        resultFloat = isUserInterFaceOrientationIsPortrait ? 216 : 162;
    } else if (curScreenType == HorsonScreenTypeWithInch3_5) {
        resultFloat = isUserInterFaceOrientationIsPortrait ? 216 : 162;
    }
    
    return resultFloat;
}
#pragma mark -- 获取当前页面所在的控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *result;
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
        
    {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(topWindow in windows)
            
        {
            
            if (topWindow.windowLevel == UIWindowLevelNormal)
                
                break;
            
        }
        
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    
    id nextResponder = [rootView nextResponder];
    HWLog(@"class:%@",nextResponder);
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        
        result = nextResponder;
        
    }
    
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil){
        
        result = topWindow.rootViewController;
    }
    else
    {
        NSAssert(NO, @"ShareKit: Could not find a root view controller. You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    }
    return result;
}



@end

@implementation HWFuntion (Common)
#pragma mark -- 解析URL
+(NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init] ;
    for (NSString *pair in pairs)
    {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


#pragma mark -- URL转码
+(NSString *)urlEcodingFromString:(NSString *)aString
{
    return [aString urlEncodeString];
}


#pragma mark -- 获取应用最新版本的信息
+(NSDictionary *)getTheLastVersionInfoWithTheAppUrl:(NSString *)urlString{
    NSDictionary *dic = [[NSDictionary alloc] init];
    NSError *error;
    NSString *urlStr =urlString;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *respone;
    if ([HWFuntion connectedToNetWork]) {
        respone = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (nil == respone) {
            return dic;
        }
        
        NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:respone options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            HWLog(@"error %@",[error description]);
            return dic;
        }
        
        NSArray *resultsArray = [appInfoDic objectForKey:@"results"];
        if (![resultsArray count]) {
            HWLog(@"error:resultsArray == nil");
            return dic;
        }
        
        NSDictionary *info = [resultsArray objectAtIndex:0];
        NSString * latesVersion = [info objectForKey:@"version"];
        NSString * trackViewUrl = [info objectForKey:@"trackViewUrl"];
        //        NSString * trackName = [info objectForKey:@"trackName"];
        
        //获取此应用的版本号
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        NSString *name = [infoDict objectForKey:@"CFBundleDisplayName"];
        
        double doubleCurrentVersion = [currentVersion doubleValue];
        double doubleUpdateVersion = [latesVersion doubleValue];
        
        BOOL isUpdate;
        
        if (doubleCurrentVersion < doubleUpdateVersion) {
            isUpdate = YES;
        }else{
            isUpdate = NO;
        }
        
        dic = @{@"isUpdate":[NSString stringWithFormat:@"%d",isUpdate],@"version":latesVersion,@"name":name,@"updateUrl":trackViewUrl};
    }
    
    return dic;
}
#pragma mark -- 获取随机的字符串
+(NSString *)getTheRandomStringWithTheCharNumber:(int)number{
    NSArray *codeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:number+1];
    
    NSString *changeString = [[NSMutableString alloc] initWithCapacity:number+2];
    for(NSInteger i = 0; i < number; i++)
    {
        NSInteger index = arc4random() % ([codeArray count] - 1);
        getStr = [codeArray objectAtIndex:index];
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr]; //把随机字符加到可变string后面，循环四次后取完
    }
    return changeString;
}

#pragma mark -- 获取随机的的一个数字
+(NSString *)getTheRandomStringWithTheNumber:(int)number{
    NSArray *codeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:number+1];
    
    NSString *changeString = [[NSMutableString alloc] initWithCapacity:number+2];
    for(NSInteger i = 0; i < number; i++)
    {
        NSInteger index = arc4random() % ([codeArray count] - 1);
        getStr = [codeArray objectAtIndex:index];
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr]; //把随机字符加到可变string后面，循环四次后取完
    }
    return changeString;
}
#pragma mark -- 比较两个日期的大小
+(NSInteger)compareDate:(NSString*)firstDate withDate:(NSString*)secondDate{
//    NSInteger ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:firstDate];
    dt2 = [df dateFromString:secondDate];
    NSComparisonResult result = [dt1 compare:dt2];
//    switch (result)
//    {
//            //date02比date01大
//        case NSOrderedAscending: ci=1; break;
//            //date02比date01小
//        case NSOrderedDescending: ci=-1; break;
//            //date02=date01
//        case NSOrderedSame: ci=0; break;
//        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
//    }
    return result;
}

+(NSInteger)getTheSecondfromDate:(NSString*)firstDate andDate:(NSString*)secondDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *preDate = [[NSDate alloc] init];
    NSDate *lateDate = [[NSDate alloc] init];
    preDate = [df dateFromString:firstDate];
    lateDate = [df dateFromString:secondDate];
    
    NSTimeInterval preTimeSecond=[preDate timeIntervalSince1970];
    NSTimeInterval lateTimeSecond=[lateDate timeIntervalSince1970];
    
    return lateTimeSecond - preTimeSecond;
}

@end

@implementation HWFuntion (ValidationString)
#pragma mark -- 邮箱的验证
+(BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark -- 手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark -- 英文用户名验证
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}
#pragma mark -- 密码验证
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
#pragma mark -- 中文昵称验证
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{3,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

#pragma mark -- QQ号码验证  腾讯QQ号从10 000 开始
+ (BOOL) validateQQNumber:(NSString *)QQNumber
{
    NSString *qqRegex = @"[1-9][0-9]{4,11}";
    NSPredicate *qqPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqPredicate evaluateWithObject:QQNumber];
}

@end

@implementation HWFuntion (EncryptAndDecrypt)
#pragma mark -- MD5加密
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String
{
    
    const char * cString = [beforeMD5String UTF8String];
    unsigned char result[16];
    CC_MD5(cString, (CC_LONG)strlen((const char *)cString), result);
    NSString *sign= [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    return sign;
}
#pragma mark -- AES128加密，再BASE64转码
+(NSString *)encryptAES128FromString:(NSString *)encryptString key:(NSString *)keyString
{
    NSString *gkey = keyString;
    NSString *gIv = @"WWWIHUIKOUNET168";
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [encryptString dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = (int)dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        HWLog(@"进行64位转化前的data :%@",resultData);
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;
}
#pragma mark -- BASE64转码，再AES128解密
+(NSString *)decodeAES128FromString:(NSString *)decryptString key:(NSString *)keyString
{
    NSString *gkey = keyString;
    //    NSString *gkey = @"IHUIKOU.COMPANY.8";
    NSString *gIv = @"WWWIHUIKOUNET168";
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[decryptString dataUsingEncoding:NSUTF8StringEncoding]];
    HWLog(@"进行64位转化后的data:%@",data);
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    size_t numBytesCrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return resultString;
    }
    free(buffer);
    return nil;
    
}
#pragma mark -- DES加密，再BASE64转码
+(NSString *) encryptUseDES:(NSString *)encryptString key:(NSString *)keyString
{
    NSString *key = keyString;
    NSData *data = [encryptString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //    NSInteger dataBytes = [data length];
    
    unsigned char buffer[90000];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          90000,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        HWLog(@"DES加密失败");
    }
    return plainText;
}

#pragma mark -- BASE64转码，再DES解密
+(NSString*) decryptUseDES:(NSString*)decryptString key:(NSString *)keyString{
    NSString *key = keyString;
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:decryptString];
    //    NSInteger dataBytes = [cipherData length];
    unsigned char buffer[90000];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          90000,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


+ (NSDictionary *)dictionaryWithModel:(id)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
//            for (classObject *object in propertyValue) {
//                
//            }
            
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    return [dict copy];
}

@end