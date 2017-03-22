//
//  HWPhotoBrowser.m
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#import "HWPhotoBrowser.h"
#import "HWPhotoBrowserConfig.h"
#import "HWBrowserImageView.h"
#import "HWPageControl.h"
@implementation HWPhotoBrowser
{
    UIScrollView *_scrollView;
    BOOL _hasShowedFistView;
    HWPageControl *_pageControl;
    UIActivityIndicatorView *_indicatorView;
    BOOL _willDisappear;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HWPhotoBrowserBackgrounColor;
        self.isReturnIndexMoreThanThree = YES;
    }
    return self;
}


- (void)didMoveToSuperview
{
    
    
    [self setupScrollView];
    
    [self setupPageControl];
}

- (void)dealloc
{
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}

- (void)setupPageControl
{

    _pageControl = [[HWPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 20, SCREEN_WIDTH, 6)
                                                         count:_imageCount
                                                 pageIndicator:@"home_pageIndicator"
                                              currentIndicator:@"home_pageIndicator_sel"];
    _pageControl.currentIndex = _currentImageIndex;
    [self addSubview:_pageControl];
    
    if (_imageCount == 1) {
        _pageControl.hidden = YES;
    }
    
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    NSLog(@"self.imageCount:%ld",(long)self.imageCount);
    for (int i = 0; i < self.imageCount; i++) {
        HWBrowserImageView *imageView = [[HWBrowserImageView alloc] init];
        imageView.tag = i;
        
        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
        
        // 双击放大图片
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
        doubleTap.numberOfTapsRequired = 2;
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        [_scrollView addSubview:imageView];
    }
    
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
    
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    HWBrowserImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
    imageView.hasLoadedImage = YES;
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer
{
    _scrollView.hidden = YES;
    _willDisappear = YES;
    
    HWBrowserImageView *currentImageView = (HWBrowserImageView *)recognizer.view;
    
    UIView *sourceView;
   
    CGRect targetTemp;
    //超过3个时，隐藏图片浏览器时，消失后的位置是视图的中心
    if (self.isReturnIndexMoreThanThree) {
        sourceView = self.sourceImageViewArray[self.currentImageIndex];
        targetTemp = [sourceView.superview convertRect:sourceView.frame toView:self];
    }
    else{
        if(self.currentImageIndex > 2)
        {
//            sourceView = self.sourceImageViewArray[self.currentImageIndex];
            targetTemp = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
        }
        else{
            sourceView = self.sourceImageViewArray[self.currentImageIndex];
            targetTemp = [sourceView.superview convertRect:sourceView.frame toView:self];
        }
    }
    
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = currentImageView.contentMode;
    tempView.clipsToBounds = YES;
    tempView.image = currentImageView.image;
    CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
    
    if (!currentImageView.image) { // 防止 因imageview的image加载失败 导致 崩溃
        h = self.bounds.size.height;
    }
    
    tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
    tempView.center = self.center;
    
    [self addSubview:tempView];
    
    
    [UIView animateWithDuration:HWPhotoBrowserHideImageAnimationDuration animations:^{
        tempView.frame = targetTemp;
        self.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer
{
    HWBrowserImageView *imageView = (HWBrowserImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    
    HWBrowserImageView *view = (HWBrowserImageView *)recognizer.view;
    
    [view doubleTapToZommWithScale:scale];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += HWPhotoBrowserImageViewMargin * 2;
    
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    
    CGFloat y = 0;
    CGFloat w = _scrollView.frame.size.width - HWPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;
    
    
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(HWBrowserImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = HWPhotoBrowserImageViewMargin + idx * (HWPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    
    if (!_hasShowedFistView) {
        [self showFirstImage];
    }
    
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [window addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        HWBrowserImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
        if ([currentImageView isKindOfClass:[HWBrowserImageView class]]) {
            [currentImageView clear];
        }
    }
}

- (void)showFirstImage
{
    UIView *sourceView = self.sourceImageViewArray[self.currentImageIndex];
    
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:self];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
    
    [self addSubview:tempView];
    
    CGRect targetTemp = _scrollView.subviews[self.currentImageIndex].bounds;;
    
    tempView.frame = rect;
    tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
     
    _scrollView.hidden = YES;
    
    
    [UIView animateWithDuration:HWPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.center = self.center;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
    } completion:^(BOOL finished) {
        _hasShowedFistView = YES;
        [tempView removeFromSuperview];
        _scrollView.hidden = NO;
    }];
}

- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}

- (NSURL *)highQualityImageURLForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }
    return nil;
}

#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    // 有过缩放的图片在拖动一定距离后清除缩放
    CGFloat margin = 150;
    CGFloat x = scrollView.contentOffset.x;
    if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
        HWBrowserImageView *imageView = _scrollView.subviews[index];
        if (imageView.isScaled) {
            [UIView animateWithDuration:0.5 animations:^{
//                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
//                [imageView eliminateScale];
            }];
        }
    }
    
    
    if (!_willDisappear) {
        _pageControl.currentIndex = index ;
    }
    [self setupImageOfImageViewForIndex:index];
}



@end
