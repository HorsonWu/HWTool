//
//  HWNetwokUploadingAnimation.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/11/21.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWNetwokUploadingAnimation.h"
#import <UIKit/UIKit.h>
@implementation HWNetwokUploadingAnimation
{
    UIView *_bigView;
}

+ (instancetype)sharedInstance {
    static HWNetwokUploadingAnimation *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HWNetwokUploadingAnimation alloc] init];
    });
    return _sharedInstance;
}


- (void)showLoadingAnimationToView:(id)view{
    if ([view isKindOfClass:[UIView class]]) {
        [self showAniWithCues:@"拼命加载中..." Panel:NO InView:YES toView:view];
    }else{
        [self showAniWithCues:@"拼命加载中..." Panel:NO InView:NO toView:nil];
    }
    
}

- (void)showAniWithCues:(NSString *)cues toView:(id)view{
    
    if ([view isKindOfClass:[UIView class]]) {
        [self showAniWithCues:cues Panel:NO InView:YES toView:view];
    }else{
        [self showAniWithCues:cues Panel:NO InView:YES toView:view];
    }
    
    
}

- (void)showAniWithCues:(NSString *)cues Panel:(BOOL)isOnPanel InView:(BOOL)isInView toView:(UIView *)view{
    
    [self hideAni];
    _bigView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _bigView.backgroundColor = [UIColor clearColor];
    
    //背景
    if (isOnPanel) {
        
        UIView * bg = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        bg.backgroundColor = [UIColor blackColor];
        bg.alpha = 0.3;
        [_bigView addSubview:bg];
        
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = CGRectMake(0, 0, 160, 80);
        effe.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 10);
        effe.layer.masksToBounds = YES;
        effe.layer.cornerRadius = 15.0;
        [_bigView addSubview:effe];
    }
    
    //动画图片
    UIImageView * aniIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48, 40)];
    aniIv.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    aniIv.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"ani_1.png"],
                             [UIImage imageNamed:@"ani_2.png"],
                             [UIImage imageNamed:@"ani_3.png"], nil];
    
    aniIv.animationDuration = 0.4;
    aniIv.animationRepeatCount = 2000;
    [aniIv startAnimating];
    [_bigView addSubview:aniIv];
    
    //提示
    UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
    msg.center = CGPointMake(SCREEN_WIDTH / 2, aniIv.frame.origin.y  + aniIv.frame.size.height + 10);
    msg.text = cues;
    msg.textColor = [UIColor colorWithHexRGB:@"#ff9600"];
    msg.font = [UIFont systemFontOfSize:14.0];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.backgroundColor = [UIColor clearColor];
    [_bigView addSubview:msg];
    
    if (isInView) {
        
        [view addSubview:_bigView];
        
    }else {
        
        [[UIApplication sharedApplication].keyWindow addSubview:_bigView];
    }
    
}

- (void)hideAni {
    [_bigView removeFromSuperview];
}
@end
