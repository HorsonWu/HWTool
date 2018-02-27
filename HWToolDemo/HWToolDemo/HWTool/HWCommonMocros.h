//
//  HWCommonMocros.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/11/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#ifndef HWCommonMocros_h
#define HWCommonMocros_h

///屏幕大小
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
///屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
///屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
///判断是否是横屏
#define IS_INTERFACE_THWARTWISE_IN SCREEN_WIDTH>SCREEN_HEIGHT?YES:NO


//按比例缩放值
#define ScaleRatio  SCREEN_WIDTH / 320.0
#define scale(x)    (x) * ScaleRatio

//公共值
#define WZNavHeight    64.0
#define WZTabbarHeight 49.0

///获取系统版本号
#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// NSUserDefaults
#define USERDEFATLTS [NSUserDefaults  standardUserDefaults]
//创建弱引用的self
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;

///16进制RGB创建UIColor
#define UIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]`

///根据RGB色值调颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define MainColor                   UIColorFromRGB(0xff9600, 1.0)
#define NavBarBackgroundColor       UIColorFromRGB(0xff9600, 1.0)
#define ViewBackgroundColor         UIColorFromRGB(0xeeeeee, 1.0)
#define LineBackgroundColor         UIColorFromRGB(0xdfdfdf, 1.0)
#define TitleColor                  UIColorFromRGB(0x333333, 1.0)
#define ContentColor                UIColorFromRGB(0x666666, 1.0)

#define ClearColor      [UIColor clearColor]
#define WhiteColor      [UIColor whiteColor]
#define BlackColor      [UIColor blackColor]

#define TitleFontStyle              [UIFont systemFontOfSize:17];
#define ContentFontStyle            [UIFont systemFontOfSize:14];

#if (DEBUG || TESTCASE)
//# define HWLog(fmt, ...) NSLog((@"[File:%s]\n" "[Function:%s]\n" "[Number:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
# define HWLog(fmt, ...) NSLog((@"INFO:[%@ %@] " fmt), NSStringFromClass([self class]), NSStringFromSelector(_cmd), ##__VA_ARGS__)
#else
# define HWLog(fmt, ...)
#endif

// 日志输出函数
#if DEBUG
#define BASE_ERROR_FUN(error)  HWLog(@"错误信息：%@",error)
#define BASE_INFO_FUN(info)    HWLog(@"信息：%@",info)
#else
#define BASE_ERROR_FUN(error)
#define BASE_INFO_FUN(info)
#endif


#endif /* HWCommonMocros_h */
