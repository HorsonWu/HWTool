//
//  HWRollingLabel.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWRollingLabel : UIView
@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UIColor * textColor;
@end
