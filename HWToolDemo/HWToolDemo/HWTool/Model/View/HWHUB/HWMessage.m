//
//  HWMessage.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWMessage.h"

@implementation HWMessage

+ (instancetype)showMessage:(NSString *)message animated:(BOOL)animated {
    HWMessage * messageView = [[self alloc] initWithMessage:message];
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[HWMessage class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:messageView];
    [messageView show:animated];
    return messageView;
}

- (void)show:(BOOL)animated {
    if (animated) {
        CGAffineTransform originTransfrom = self.transform;
        self.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = originTransfrom;
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
        }];
    }else {
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
        self.y += 10.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (instancetype)initWithMessage:(NSString *)message {
    if (self = [super init]) {
        //计算字符串的尺寸
        CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        
        //创建Label
        CGFloat w, h;
        if (textSize.width + 30 > SCREEN_WIDTH) {
            CGFloat textW = SCREEN_WIDTH * 2 / 3;
            h = (textSize.width / textW + 1) * textSize.height + 20;
            w = textW + 30;
        }else {
            h = textSize.height + 20;
            w = textSize.width + 30;
        }
        UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        msg.text = message;
        msg.font = [UIFont systemFontOfSize:15.0];
        msg.numberOfLines = 0;
        msg.textAlignment = NSTextAlignmentCenter;
        msg.backgroundColor = [UIColor darkGrayColor];
        msg.textColor = [UIColor whiteColor];
        msg.layer.masksToBounds = YES;
        msg.layer.cornerRadius = (textSize.height + 20) / 2;
        [self addSubview:msg];
        //
        self.frame = CGRectMake(SCREEN_WIDTH / 2 - msg.frame.size.width / 2, SCREEN_HEIGHT * 7.0 / 9.0, msg.frame.size.width, msg.frame.size.height);
    }
    return self;
}



@end
