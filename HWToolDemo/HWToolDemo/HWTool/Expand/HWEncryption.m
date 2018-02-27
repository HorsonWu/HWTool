//
//  HWEncryption.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWEncryption.h"
#import "HWAES128Util.h"
@implementation HWEncryption
+ (NSString*)getEncryptedStrWithUrlString:(NSString*)URLString parameters:(NSDictionary*)parameters {
    HWLog(@"URLString：%@, parameters：%@", URLString, parameters);
    //1. 从平台上申请到key秘钥，并通过md5加密
    NSString * key = @"app2015*wz";
    HWLog(@"平台的key：%@", key);
    NSString * md5Key = [HWFuntion getMD5StrFromString:key];
    HWLog(@"平台的key进行md5加密：%@", md5Key);
    
    
    //2. 传输的参数body内容通过ASCII做升序排列，组合成需要签名的内容content(如a=1&b=2&c=3&d=4&g=5&h=6)
    //3. 拼接md5(key)+content+"*&wz$#2012",生成新的内容newContent，并通过md5再加密，形成最终的md5(newContent)
    NSString * content = [NSString stringWithFormat:@"%@%@*&wz$#2012", [md5Key uppercaseString], parameters ? [parameters sortedString] : @""];
    HWLog(@"拼接内容：%@", content);
    NSString * md5Content = [HWFuntion getMD5StrFromString:content];
    HWLog(@"拼接内容进行md5加密：%@", md5Content);
    
    
    //4. 拼接成签名signContent：app版本+"\n"+md5(newContent)+"\n"+当前时间的时间戳
    NSString * signContent = [NSString stringWithFormat:@"%@\n%@\n%@", [HWFuntion getClientVersion], [md5Content uppercaseString], [HWFuntion getTimeStamp]];
    HWLog(@"拼接成签名signContent：%@", signContent);
    
    
    //5. 通过AES进行加密signContent形成最终的sign字符串
    NSString * aesSignContent = [HWAES128Util AES128Encrypt:signContent aesKey:[[md5Key uppercaseString]substringToIndex:16]];
    HWLog(@"签名进行aes加密：%@", aesSignContent);
    //
    return aesSignContent;
}

@end
