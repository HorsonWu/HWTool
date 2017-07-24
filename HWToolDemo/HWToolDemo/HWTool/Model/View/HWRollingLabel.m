//
//  HWRollingLabel.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWRollingLabel.h"
@interface HWRollingLabel ()
@property (nonatomic, strong) UILabel * label;
@end

@implementation HWRollingLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc]initWithFrame:self.bounds];
        [self addSubview:self.label];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    [self startRollingAnimation];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.label.font = font;
    [self startRollingAnimation];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.label.textAlignment = textAlignment;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.label.backgroundColor = backgroundColor;
}

- (void)updateLabelFrame {
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.label.font}];
    CGFloat textLength = ceilf(size.width);
    self.label.frame = CGRectMake(0, 0, textLength > self.w ? textLength : self.w, self.h);
}

- (void)startRollingAnimation {
    //停止动画
    [self.layer removeAllAnimations];
    //调整label的frame
    [self updateLabelFrame];
    //开始动画
    if (self.label.w > self.w) {
        [self rightAni];
    }
}

- (void)rightAni {
    [UIView animateWithDuration:4.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label.x = self.w - self.label.w;
    } completion:^(BOOL finished) {
        [self leftAni];
    }];
}

- (void)leftAni {
    [UIView animateWithDuration:4.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label.x = 0.f;
    } completion:^(BOOL finished) {
        [self rightAni];
    }];
}



@end
