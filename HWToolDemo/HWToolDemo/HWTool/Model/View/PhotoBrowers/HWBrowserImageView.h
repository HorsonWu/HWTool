//
//  HWBrowerImageView.h
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWBrowserImageView : UIImageView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

- (void)eliminateScale; // 清除缩放

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;


@end
