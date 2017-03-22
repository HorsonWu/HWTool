//
//  NSString+HW.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HW)
/**
 *	@brief	URL转码的方法
 *
 *	@return	URL转码以后的字符串
 */
- (NSString *)urlEncodeString;


#pragma mark -- 对字符串的常用判断
/**
 * @breif 验证字符串是否符合邮箱格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidateEmail;
/**
 * @breif 验证字符串是否符合手机格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidateMobile;
/**
 * @breif 验证字符串是否符合英文用户名格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidateUserName;
/**
 * @breif 验证字符串是否符合密码格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidatePassword;
/**
 * @breif 验证字符串是否符合中文昵称格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidateNickname;
/**
 * @breif 验证字符串是否符合QQ号码格式
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
- (BOOL) isValidateQQNumber;


#pragma mark -- 文件目录部分的操作
/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir;

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir;

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir;
@end
