//
//  HWPhotoHandleView.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/28.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWPhotoHandleView.h"

@implementation HWPhotoHandleView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES ;
        self.photoView = [UIImageView new];
        self.photoView.frame = CGRectMake(0, 20.0/750*SCREEN_WIDTH,120.0/750*SCREEN_WIDTH, 120.0/750*SCREEN_WIDTH);
        [self addSubview:self.photoView];
    }
    return self;
}

-(void)canTouch{
    if (self.deleteBtn) {
        self.deleteBtn = nil;
        [self.deleteBtn removeFromSuperview];
    }
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
    self.tap.numberOfTapsRequired = 1;
    self.tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:self.tap];
}
-(void)canDelete{
    if (self.tap) {
        self.tap = nil;
        [self removeGestureRecognizer:self.tap];
    }
    
    self.deleteBtn = [UIButton new];
    self.deleteBtn.frame = CGRectMake(self.photoView.frame.size.width+self.photoView.frame.origin.x-20.0/750*SCREEN_WIDTH, self.photoView.frame.origin.y-20.0/750*SCREEN_WIDTH, 40.0/750*SCREEN_WIDTH, 40.0/750*SCREEN_WIDTH);
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

-(void)action{
    self.viewBlock(self);
}

-(void)btnAction:(UIButton *)btn{
    self.buttonBlock(btn);
}

@end
