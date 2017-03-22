//
//  HWTabbarView.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWTabbarView.h"
#import "HWCommonMocros.h"
@implementation HWTabbarView
{
//    UIImageView *_imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:(CGRect)frame];
    if (self)
    {
        
    }
    return self;
}

-(void)configureTabbarWithNormalImageArray:(NSArray*)normalImageArray selectImageArray:(NSArray *)selectImageArray tabbarTitleArray:(NSArray *)tabbarTitleArray
{
    self.userInteractionEnabled = YES;
    
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  SCREEN_HEIGHT- 49, SCREEN_WIDTH, 49)];
//    _imageView.userInteractionEnabled = YES;
//    _imageView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:_imageView];
//    
    
    for (int i = 0; i < tabbarTitleArray.count; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * SCREEN_WIDTH/tabbarTitleArray.count, 0, SCREEN_WIDTH/tabbarTitleArray.count, self.frame.size.height);
        [button setTitle:tabbarTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:normalImageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageArray[i]] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:30/255.0 alpha:1] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleEdgeInsets = UIEdgeInsetsMake(30, -23, 5, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 20, 20);
        
        button.tag = 100001 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag == 100001)
        {
            button.selected = YES;
        }
        [self addSubview:button];
        
    }
}
- (void)buttonClick:(UIButton *)button
{
    self.buttonBlock(button);
}

@end
