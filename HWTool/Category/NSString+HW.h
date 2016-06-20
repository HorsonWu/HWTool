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

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
@end
