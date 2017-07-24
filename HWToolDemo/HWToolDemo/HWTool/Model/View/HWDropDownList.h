//
//  HWDropDownList.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropDownList : UIView
/* 选择的回调 */
@property (nonatomic, copy) void(^callBackBlack)(NSString * selectedItem, int selectedIndex);

/* 初始化 view：需要下拉列表的view   soureArray：列表的数据 */
- (id)initWithView:(UIView *)view SourceArray:(NSArray *)sourceArray;

//- (id)initWithSender:(UIViewController *)sender view:(UIView *)view SourceArray:(NSArray *)sourceArray;


@end
