//
//  HWRatingBar.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/18.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWRatingBar.h"
@interface HWRatingBar (){
    float starRating;
    float lastRating;
    
    float height;
    float width;
    
    UIImage *unSelectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
}

@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;



@end

@implementation HWRatingBar
/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate{
    
    self.delegate = delegate;
    
    unSelectedImage = [UIImage imageNamed:deselectedName];
    halfSelectedImage = halfSelectedName == nil ? unSelectedImage : [UIImage imageNamed:halfSelectedName];
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    
    height = 0.0,width = 0.0;
    
    if (height < [fullSelectedImage size].height) {
        height = [fullSelectedImage size].height;
    }
    if (height < [halfSelectedImage size].height) {
        height = [halfSelectedImage size].height;
    }
    if (height < [unSelectedImage size].height) {
        height = [unSelectedImage size].height;
    }
    if (width < [fullSelectedImage size].width) {
        width = [fullSelectedImage size].width;
    }
    if (width < [halfSelectedImage size].width) {
        width = [halfSelectedImage size].width;
    }
    if (width < [unSelectedImage size].width) {
        width = [unSelectedImage size].width;
    }
    
    starRating = 0.0;
    lastRating = 0.0;
    
    _s1 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s2 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s3 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s4 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s5 = [[UIImageView alloc] initWithImage:unSelectedImage];
    
    [_s1 setFrame:CGRectMake(0 , 0, width, height)];
    [_s2 setFrame:CGRectMake(1 * (width + self.space), 0, width, height)];
    [_s3 setFrame:CGRectMake(2 * (width + self.space), 0, width, height)];
    [_s4 setFrame:CGRectMake(3 * (width + self.space), 0, width, height)];
    [_s5 setFrame:CGRectMake(4 * (width + self.space), 0, width, height)];
    
    [_s1 setUserInteractionEnabled:NO];
    [_s2 setUserInteractionEnabled:NO];
    [_s3 setUserInteractionEnabled:NO];
    [_s4 setUserInteractionEnabled:NO];
    [_s5 setUserInteractionEnabled:NO];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
    
    CGRect frame = [self frame];
    frame.size.width = width * 5 - self.space;
    frame.size.height = height;
    [self setFrame:frame];
    
}

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
-(void)displayRating:(float)rating{
    [_s1 setImage:unSelectedImage];
    [_s2 setImage:unSelectedImage];
    [_s3 setImage:unSelectedImage];
    [_s4 setImage:unSelectedImage];
    [_s5 setImage:unSelectedImage];
    
    if (rating >= 0.5) {
        [_s1 setImage:halfSelectedImage];
    }
    if (rating >= 1) {
        [_s1 setImage:fullSelectedImage];
    }
    if (rating >= 1.5) {
        [_s2 setImage:halfSelectedImage];
    }
    if (rating >= 2) {
        [_s2 setImage:fullSelectedImage];
    }
    if (rating >= 2.5) {
        [_s3 setImage:halfSelectedImage];
    }
    if (rating >= 3) {
        [_s3 setImage:fullSelectedImage];
    }
    if (rating >= 3.5) {
        [_s4 setImage:halfSelectedImage];
    }
    if (rating >= 4) {
        [_s4 setImage:fullSelectedImage];
    }
    if (rating >= 4.5) {
        [_s5 setImage:halfSelectedImage];
    }
    if (rating >= 5) {
        [_s5 setImage:fullSelectedImage];
    }
    

    lastRating = rating;
    

}

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
-(float)rating{
    return lastRating;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.isIndicator) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width) + 1;
    if (newRating > 5)
        return;
    
    if (point.x < 0) {
        newRating = 0;
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
        
        [self.delegate getTheBarRatingFromHWRating:self];
    }
    
//    [super touchesEnded:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesMoved:touches withEvent:event];

}


#pragma delegate
/**
 *  评分改变
 *
 *  @param newRating 新的值
 */
- (void)ratingChanged:(float)newRating{
    [self displayRating:newRating];
}

///**
// *  获取相对应的ratingBar的评分
// *
// *  @param ratingBar 评分条
// */
//- (void)getTheBarRatingFromHWRating:(HWRatingBar *)ratingBar{
//    
//    
//}
@end
