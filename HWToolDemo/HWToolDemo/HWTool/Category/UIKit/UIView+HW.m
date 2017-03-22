//
//  UIView+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIView+HW.h"

@implementation UIView (HW)



#pragma mark - 画像素为1的线
+ (instancetype)drawVerticalLineWithFrame:(CGRect)frame {
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x , frame.origin.y, 1, frame.size.height)];
    line.backgroundColor = [UIColor colorWithHexRGB:@"#dfdfdf"];
    return line;
}

+ (instancetype)drawHorizonLineWithFrame:(CGRect)frame {
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y , frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithHexRGB:@"#dfdfdf"];
    return line;
}


#pragma mark - Animation

- (void)startShakeAnimation
{
    CGFloat rotation = 0.05;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.2;
    shake.autoreverses = YES;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -rotation, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  rotation, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)stopShakeAnimation
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

- (void)startRotateAnimation
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.5;
    shake.autoreverses = NO;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, M_PI, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  0.0, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"rotateAnimation"];
}

- (void)stopRotateAnimation
{
    [self.layer removeAnimationForKey:@"rotateAnimation"];
}


#pragma mark - 截图
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 2.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
