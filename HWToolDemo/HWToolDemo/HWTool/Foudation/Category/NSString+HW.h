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


/**
*  通过label宽度和字体大小计算它的自动换行高度
*/
- (CGFloat)getHeightWithLabelWidth:(float)labelWidth fontSize:(float)fontSize;

/**
 *  计算字符数
 */
- (NSInteger)getCharCount;

/**
 *  显示高亮字体
 */
- (NSAttributedString *)attributedStringWithHighLightString:(NSString *)keyword hightLightColor:(UIColor *)color;
/**
 *  合并字符串
 */
- (NSAttributedString *)appendAttributedString:(NSAttributedString *)attributedString;


/*
 * 将字符串转换为
 */
+ (void)convertString:(NSString *)source toHexBytes:(unsigned char *)hexBuffer;

/*
 * 将当前时间转换为时间戳字符串：since 1970，如@"1369118167"
 */
+ (NSString *)intervalFromNowTime;

/*
 * 删除中文输入法下的空格
 */
+ (NSString *)deleteChinesSpace:(NSString *)sourceText;

/*
 * 转化为字符串类型
 */
+ (NSString *)stringFromObject:(id)obj;

/*
 * 将URL的查询字符串放入字典中如：http://..?userName=name&password=password
 * 将查询字符串userName=name&password=password 放入字典
 */
+ (NSDictionary *)parseURLQueryString:(NSString *)queryString;

/*
 * 将unicode码转成普通文字.(\u6790)
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeString;


- (NSAttributedString *)attributedStringWithHighLightString:(NSString *)keyword highLightColor:(UIColor *)hightLightColor highLightFontSize:(CGFloat)highLightFontSize andOriginColor:(UIColor *)originColor andOriginFontSize:(CGFloat)originFontSize;

- (NSString *)appendNonullString:(NSString *)aString;
- (NSString *)appendNonullString:(NSString *)aString hint:(BOOL)showHint;


@end
