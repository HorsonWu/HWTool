//
//  HWPageControl.m
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#import "HWPageControl.h"
#define IndicatorW self.bounds.size.height

@interface HWPageControl ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)   NSString * pageIndicator;
@property (nonatomic, copy)   NSString * currentIndicator;

@property (nonatomic, strong) NSMutableArray<UIImageView *> * indicatorArray;
@property (nonatomic, assign) NSInteger index;

@end


@implementation HWPageControl


- (instancetype)initWithFrame:(CGRect)frame
                        count:(NSInteger)count
                pageIndicator:(NSString *)pageIndicator
             currentIndicator:(NSString *)currentIndicator {
    if (self = [super initWithFrame:frame]) {
        self.count = count;
        self.pageIndicator = pageIndicator;
        self.currentIndicator = currentIndicator;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.index = 0;
    self.indicatorArray = [NSMutableArray array];
    UIView * pageControl = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IndicatorW * 2 * self.count, IndicatorW)];
    for (NSInteger i = 0; i < self.count; i ++) {
        UIImageView * indicator = [[UIImageView alloc]initWithFrame:CGRectMake(IndicatorW * i * 2, 0, IndicatorW, IndicatorW)];
        indicator.image = [UIImage imageNamed:i == self.index ? self.currentIndicator : self.pageIndicator];
        [pageControl addSubview:indicator];
        [self.indicatorArray addObject:indicator];
    }
    [pageControl setCenter:CGPointMake(CGRectGetMidX(self.frame), 0)];
    [self addSubview:pageControl];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex != _currentIndex) {
        [[self.indicatorArray objectAtIndex:_currentIndex] setImage:[UIImage imageNamed:self.pageIndicator]];
        [[self.indicatorArray objectAtIndex:currentIndex] setImage:[UIImage imageNamed:self.currentIndicator]];
    }
    _currentIndex = currentIndex;
}

@end
