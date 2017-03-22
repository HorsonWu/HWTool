//
//  NSString+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "NSString+HW.h"

@implementation NSString (HW)
- (NSString *)urlEncodeString
{
    NSString *result =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                          (CFStringRef)self,
                                                                          NULL,
                                                                          (CFStringRef)@";/?:@&=$+{}<>,",
                                                                          kCFStringEncodingUTF8));
    return result ;
}


#pragma mark -- 对字符串的常用判断
- (BOOL) isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL) isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL) isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

- (BOOL) isValidatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL) isValidateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{3,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL) isValidateQQNumber
{
    NSString *qqRegex = @"[1-9][0-9]{4,11}";
    NSPredicate *qqPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqPredicate evaluateWithObject:self];
}


#pragma mark -- 文件目录部分的操作
- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}
// 在传入的路径后拼接当前的字符串
- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}


@end
