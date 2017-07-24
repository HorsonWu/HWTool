//
//  HWPointsAddedHint.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

/*
 * 从底部弹出的送积分的视图
 */

#import <UIKit/UIKit.h>

@interface HWPointsAddedHint : UIView
+ (instancetype)showPointsAdded:(NSString *)points animated:(BOOL)animated;

@end
