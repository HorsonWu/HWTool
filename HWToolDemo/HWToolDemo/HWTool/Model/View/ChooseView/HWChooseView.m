//
//  HWChooseView.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/27.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWChooseView.h"

@implementation HWChooseView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES ;
        self.chooseImageView = [UIImageView new];
        self.chooseImageView.frame = CGRectMake(10.0/750*SCREEN_WIDTH, 20.0/750*SCREEN_WIDTH, 32.0/750*SCREEN_WIDTH, 32.0/750*SCREEN_WIDTH);
        [self addSubview:self.chooseImageView];
        
        self.statusLabel = [UILabel new];
        self.statusLabel.frame = CGRectMake(self.chooseImageView.frame.size.width+self.chooseImageView.frame.origin.x+10.0/750*SCREEN_WIDTH, 15.0/750*SCREEN_WIDTH, 80.0/750*SCREEN_WIDTH, 40.0/750*SCREEN_WIDTH);
        [self addSubview:self.statusLabel];
       
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

-(void)action{
    self.viewBlock(self);
}



//-(void)viewAction:(UIView *)view{
//    
//    self.viewBlock(view);
//}
@end
