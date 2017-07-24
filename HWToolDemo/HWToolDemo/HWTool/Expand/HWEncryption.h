//
//  HWEncryption.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

/*
 实现签名认证 2016-12-28
 
 解决问题
 1. 请求参数被篡改
 2. 请求的唯一性(不可复制)，防止请求被恶意攻击
 
 签名流程：(需用到算法：MD5、AES)
 1. 从平台上申请到key秘钥，并通过md5加密
 2. 传输的参数body内容通过ASCII做升序排列，组合成需要签名的内容content(如a=1&b=2&c=3&d=4&g=5&h=6)
 3. 拼接md5(key)+content+"*&wz$#2012",生成新的内容newContent，并通过md5再加密，形成最终的md5(newContent)
 4. 拼接成签名signContent：app版本+"\n"+md5(newContent)+"\n"+当前时间的时间戳
 5. 通过AES进行加密signContent形成最终的sign字符串
 
 */

#import <Foundation/Foundation.h>

@interface HWEncryption : NSObject
+ (NSString*)getEncryptedStrWithUrlString:(NSString*)URLString parameters:(NSDictionary*)parameters;

@end
