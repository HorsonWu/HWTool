//
//  HWFuntion.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//


#import "NSObject+HW.h"
/**
 *	@brief	枚举，屏幕类型；按屏幕尺寸区分
 *
 *	@param 	NSInteger 	0开始
 *	@param 	HORSON_SCREEN_TYPE 	包括六种：
 
 */
typedef NS_ENUM(NSInteger, HorsonScreenType)

{
    HorsonScreenTypeWithInch3_5 = 0,            //3.5寸屏幕
    HorsonScreenTypeWithInch4_0,                //4.0寸屏幕
    HorsonScreenTypeWithInch4_7,                //4.7寸屏幕
    HorsonScreenTypeWithInch5_5,                //5.5寸屏幕
    HorsonScreenTypeWithIpadSize,               //ipad屏幕
    HorsonScreenTypeWithSizeUnknow              //未知屏幕
};


#pragma marking -- 获取系统常用参数的处理
@interface HWFuntion : NSObject
/**
 *	@brief	获取时间戳
 *
 *	@return	字符串的形式，从1970年一月一日零点到当前时间的毫秒数。
 样例：1392717252908
 */
+(NSString *)getTimeStamp;

/**
 *	@brief	获取当前日期，年月日 时分
 *
 *	@return	字符串，样例：“2014-02-18_18:30”
 */
+(NSString *)getTimeDate;

/**
 *	@brief	获取设备类型
 *
 *	@return	设备类型的字符串：样例："iPod_touch_5"
 */
+(NSString *)getDeviceType;

/**
 *	@brief	获取当前设备的类型，主要按尺寸区分。
 *
 *	@return	自定的枚举类型 HorsonScreenType ，详细见顶部。
 */
+(HorsonScreenType)getCurrentScreenType;
/**
 *	@brief	根据当前屏幕类型，获取满屏幕的大小尺寸。
 *
 *	@return	CGrect，一个位置是（0,0）尺寸是当前屏幕大小的frame
 */
+(CGRect)getCurrentScreenFrame;

/**
 *	@brief	获取IP地址，c级别的方法，源码来源于网络
 *
 *	@return 样例：“172.16.10.20”
 */
+(NSString *)getIPAddress;
/**
 *	@brief	获取当前设备的mac地址 iOS7以下有效，iOS7以上也能使用，但是值都是一样的。
 *
 *	@return	返回设备的mac地址，样例："70:11:24:4B:2B:5C"
 */
+(NSString *)getMacaddress;

/**
 *	@brief	获取设备的广告标示，通过设置，可以修改的一个标记，一般情况下不会变动。
 可以跨应用，跨开发者访问。调用 ADSupport框架。只支持iOS6.0以上版本。
 *
 *	@return	一串广告标示字符串，样例：“B9031A0C-0E66-40EE-ACA4-3CCB30DB9F49”
 */
+(NSString *)getIdfa;

/**
 *	@brief	获取设备的唯一识别码，通过设置，可以修改的一个标记，一般情况下不会变动。
 可以跨应用，跨开发者访问。UUID一般只生成一次，保存在iOS系统里面，如果应用删除了，
 重装应用之后它的UUID还是一样的，除非系统重置 。但是不能保证在以后的系统升级后还能用
 *
 *	@return	一串字符串，样例：“B9031A0C-0E66-40EE-ACA4-3CCB30DB9F49”
 */
+(NSString*) getUUID;

/**
 *	@brief	获取当前iOS操作系统的版本号
 *
 *	@return	字符串形式返回当前系统的版本号,样例：“7.0”
 */
+(float)getSystemVersion;

/**
 *	@brief	获取键盘高度
 *
 *	@return	键盘高度
 */
+ (CGFloat)heightFromKeyboard;

/**
 *	@brief	判断设备是否连接网络
 *
 *	@return	BOOL，YES：设备连接了网络；NO：设备未连接任何网络
 */
+(BOOL)connectedToNetWork;

/**
 *	@brief	获取项目配置文件的配置信息
 *
 *	@return	字典Info.plist的内容
 */
+(NSDictionary *)getProjectInfoPlist;


/**
 *	@brief	获取当前页面所在的控制器
 *
 *	@return	返回当前的控制器
 */
+ (UIViewController *)getCurrentVC;
@end


#pragma marking -- 常用方法的处理
@interface HWFuntion (Common)
/**
 *	@brief	URL解析
 *
 *	@param 	query 	解析前的URL
 *
 *	@return	解析后的字典
 */
+(NSDictionary*)parseURLParams:(NSString *)query;

/**
 *	@brief	进行URL转码的方法
 *
 *	@param 	aString 	需要进行URL转吗的字符串
 *
 *	@return	URL转码以后的字符串
 */
+(NSString *)urlEcodingFromString:(NSString *)aString;

/**
 *	@brief	获取应用最新版本的信息
 *
 *	@param 	urlString 	应用的信息地址 如@"http://itunes.apple.com/lookup?id=714980045"
 *
 *	@return	字典Info.plist的内容
 */
+(NSDictionary *)getTheLastVersionInfoWithTheAppUrl:(NSString *)urlString;


/**
 *	@brief	       获取随机字符串
 *
 *  @param 	@number     生成字符串的位数
 *
 *  @return         返回随机的字符串
 *
 */
+(NSString *)getTheRandomStringWithTheCharNumber:(int)number;


/**
 *	@brief	       获取随机的数字
 *
 *  @param 	@number     生成数字的位数
 *
 *  @return         返回随机的字符串
 *
 */
+(NSString *)getTheRandomStringWithTheNumber:(int)number;


/**
 *	@brief	       比较两个日期的大小
 *
 *  @param 	firstDate     第一个日期
 *          secondDate    第二个日期
 *
 *  @return   返回的结果：firstDate前于secondDate，返回-1;firstDate等于secondDate，返回0;firstDate后于secondDate，返回1;
 *
 */
+(NSInteger)compareDate:(NSString*)firstDate withDate:(NSString*)secondDate;


/**
 *	@brief	       获取两个日期的时间差 （已秒数为单位）
 *
 *  @param 	firstDate     第一个日期
 *          secondDate    第二个日期
 *
 *  @return 两个日期的时间差
 *
 */
+(NSInteger)getTheSecondfromDate:(NSString*)firstDate andDate:(NSString*)secondDate;
@end
#pragma marking -- 字符串验证部分的处理
@interface HWFuntion (ValidationString)
/**
 * @breif 验证字符串是否符合邮箱格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validateEmail:(NSString *)email;
/**
 * @breif 验证字符串是否符合手机格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validateMobile:(NSString *)mobile;
/**
 * @breif 验证字符串是否符合英文用户名格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validateUserName:(NSString *)name;
/**
 * @breif 验证字符串是否符合密码格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validatePassword:(NSString *)passWord;
/**
 * @breif 验证字符串是否符合中文昵称格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validateNickname:(NSString *)nickname;
/**
 * @breif 验证字符串是否符合QQ号码格式
 * @email 验证的字符串
 * @return BOOL  YES：表示符合，NO：表示不符合
 */
+ (BOOL) validateQQNumber:(NSString *)QQNumber;

@end


#pragma marking -- 加密与解密的处理
@interface HWFuntion (EncryptAndDecrypt)
/**
 *	@brief	MD5加密方法
 *
 *	@param 	beforeMD5String 	加密前的MD5字符串
 *
 *	@return	加密以后的MD5字符串
 */
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String;
/**
 *	@brief	字符串加密方法  （先用AES128 CBC 方法加密，再用GTMBase64转码）
 *
 *	@param 	encryptString 	加密前的字符串（要加密的字符串）
 *
 *	@param 	keyString       密钥（加密和解密的密钥必须一样）
 *
 *	@return	加密后的字符串
 */
+(NSString *)encryptAES128FromString:(NSString *)encryptString key:(NSString *)keyString;

/**
 *	@brief	解密被加密字符串 （先用GTMBase64转码，再用AES128 CBC 解密）
 *
 *	@param 	decryptString 	被加密的字符串（要解密的字符串）
 *
 *	@param 	keyString       密钥（加密和解密的密钥必须一样）
 *
 *	@return	解密后的字符串
 */
+(NSString *)decodeAES128FromString:(NSString *)decryptString key:(NSString *)keyString;

/**
 *	@brief	字符串加密方法  （先用DES方法加密，再用GTMBase64转码）
 *
 *	@param 	encryptString 	加密前的字符串（要加密的字符串）
 *
 *	@param 	keyString       密钥（加密和解密的密钥必须一样）
 *
 *	@return	加密后的字符串
 */
+(NSString*) encryptUseDES:(NSString *)encryptString key:(NSString *)keyString;
/**
 *	@brief	字符串加密方法  （先用GTMBase64转码，再用DES解密）
 *
 *	@param 	decryptString 	被加密的字符串（要解密的字符串）
 *
 *	@param 	keyString       密钥（加密和解密的密钥必须一样）
 *
 *	@return	解密后的字符串
 */
+(NSString*) decryptUseDES:(NSString*)decryptString key:(NSString *)keyString;


+ (NSDictionary *)dictionaryWithModel:(id)model;

@end