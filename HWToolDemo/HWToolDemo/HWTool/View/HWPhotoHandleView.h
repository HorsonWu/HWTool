//
//  HWPhotoHandleView.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/28.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIView+HW.h"
typedef void(^BaseBlock)(id);
@interface HWPhotoHandleView : UIView
@property (nonatomic, strong)UIImageView *photoView;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (copy, nonatomic)BaseBlock buttonBlock;
@property (copy, nonatomic)BaseBlock viewBlock;
-(void)canTouch;
-(void)canDelete;
@end
