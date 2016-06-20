//
//  HWTabbarView.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIView+HW.h"
typedef void(^BaseBlock)(id);
@interface HWTabbarView : UIView
@property (copy, nonatomic)BaseBlock buttonBlock;
@property (copy, nonatomic)BaseBlock viewBlock;
/**
 *	@brief	通过图片数组和标题数组初始化TabBarView
 *
 *	@param 	normalImageArray 	未选中的tabBarItem的背景图片数组
 *
 *	@param 	selectImageArray    选中的tabBarItem的背景图片数组
 *
 *  @param  tabbarTitleArray    tabBarItem的标题数组
 *
 *	@return	解密后的字符串
 */
-(void)configureTabbarWithNormalImageArray:(NSArray*)normalImageArray selectImageArray:(NSArray *)selectImageArray tabbarTitleArray:(NSArray *)tabbarTitleArray;



@end
