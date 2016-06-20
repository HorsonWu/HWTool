//
//  HWRatingBar.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/18.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HWRatingBar;
/**
 *  星级评分条代理
 */
@protocol RatingBarDelegate <NSObject>

@optional
/**
 *  评分改变
 *
 *  @param newRating 新的值
 */
- (void)ratingChanged:(float)newRating;
/**
 *  获取相对应的ratingBar的评分
 *
 *  @param ratingBar 评分条
 */
- (void)getTheBarRatingFromHWRating:(HWRatingBar *) ratingBar;

@end
@interface HWRatingBar : UIView
/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate;

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
- (void)displayRating:(float)rating;

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
- (float)rating;
/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;

/**
 *  星星之间的间隔大小，需在setImage方法前设置才起作用
 */
@property (nonatomic,assign) int space;

@property (nonatomic,weak)id <RatingBarDelegate> delegate;

@end

