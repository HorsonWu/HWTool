//
//  HWAES128Util.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAES128Util : NSObject
//aesKey: 必须为16位长度的字符串

/**
 *  AES128加密
 *  @param plainText 原文
 *  @param aesKey 加密用的key
 *  @return 加密好的字符串
 */
+ (NSString *)AES128Encrypt:(NSString *)plainText aesKey:(NSString*)aesKey;

/**
 *  AES128解密
 *  @param encryptText 密文
 *  @param aesKey 加密用的key
 *  @return 明文
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText aesKey:(NSString*)aesKey;


@end
