//
//  HWPointsAddedHint.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWPointsAddedHint.h"

@implementation HWPointsAddedHint{
    NSString * pointsStr;
    UIImageView * bgImg;
    UIImageView * addImg;
}

+ (instancetype)showPointsAdded:(NSString *)points animated:(BOOL)animated {
    HWPointsAddedHint * pointsHint = [[self alloc] initWithPoints:points];
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[HWPointsAddedHint class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:pointsHint];
    [pointsHint show:animated];
    return pointsHint;
}

- (instancetype)initWithPoints:(NSString*)points {
    if (self = [super init]) {
        pointsStr = points;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    //
    self.frame = CGRectMake(scale(70), scale(496), scale(180),scale(61));
    self.backgroundColor = [UIColor clearColor];
    //
    bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgImg.image = [UIImage imageNamed:@"msg_bg"];
    [self addSubview:bgImg];
    //
    UILabel * prizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(scale(35), scale(15), scale(38), scale(25))];
    prizeLabel.text = @"奖励";
    prizeLabel.textColor = WhiteColor;
    prizeLabel.font =[UIFont systemFontOfSize:scale(18)];
    [self addSubview:prizeLabel];
    //
    UILabel * pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(scale(96), scale(15), scale(50), scale(25))];
    pointsLabel.text = [NSString stringWithFormat:@"%@积分",pointsStr];
    pointsLabel.textColor = WhiteColor;
    pointsLabel.font =[UIFont systemFontOfSize:scale(18)];
    [self addSubview:pointsLabel];
    //
    addImg = [[UIImageView alloc]initWithFrame:CGRectMake(scale(80), scale(22), scale(12), scale(12))];
    addImg.image = [UIImage imageNamed:@"icon_jia"];
    [self addSubview:addImg];
}

- (void)show:(BOOL)animated {
    if (animated) {
        self.alpha = 0.f;
        [UIView animateWithDuration:0.5 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 1.0;
            self.y -= scale(40);
        } completion:^(BOOL finished) {
            [self addImgAnimation];
        }];
    }else {
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
    }
}

- (void)addImgAnimation {
    CGAffineTransform originTransfrom = addImg.transform;
    [UIView animateWithDuration:0.2 delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        addImg.transform = CGAffineTransformMakeScale(1.7, 1.7);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            addImg.transform = originTransfrom;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:1.2];
        }];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
