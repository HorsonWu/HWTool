//
//  HWPageControl.h
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWPageControl : UIView
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame
                        count:(NSInteger)count
                pageIndicator:(NSString *)pageIndicator
             currentIndicator:(NSString *)currentIndicator;

@end
