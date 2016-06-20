//
//  HWADScrollView.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HWADScrollViewDelegate <NSObject>

-(void)didClick:(id)data;
-(void)currentPage:(int)page total:(NSUInteger)total;

@end

@interface HWADScrollView : UIScrollView<UIScrollViewDelegate>
{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    int currentPage;
    CGSize imageSize;
    UIImage *image;
}

@property(nonatomic,strong)NSArray * pics;
@property(nonatomic,retain)id<HWADScrollViewDelegate> HWAdDelegate;
-(void)releaseTimer;
-(void)upDate;

@end
