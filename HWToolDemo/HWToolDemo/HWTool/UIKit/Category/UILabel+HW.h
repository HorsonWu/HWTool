//
//  UILabel+HW.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface UILabel (HW)
/*
 获得Label的大小，常用于自适应高度
 */
- (CGSize)boundsSize:(CGSize)size;
@end
