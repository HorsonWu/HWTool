//
//  HWPhotoBrowser.h
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWPhotoBrowser;

@protocol HWPhotoBrowserDelegate <NSObject>

@required
//缩略图
- (UIImage *)photoBrowser:(HWPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
@optional
//高清图
- (NSURL *)photoBrowser:(HWPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end

@interface HWPhotoBrowser : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *sourceImageViewArray;//查看的图片的imageView数组
@property (nonatomic, assign) NSInteger currentImageIndex;//当前选中的图片位置
@property (nonatomic, assign) NSInteger imageCount;//图片的个数
@property (nonatomic, assign) BOOL isReturnIndexMoreThanThree; //返回的图片的坐标是否大于3，默认是大于3,
@property (nonatomic, weak) id<HWPhotoBrowserDelegate> delegate;

- (void)show;

@end
