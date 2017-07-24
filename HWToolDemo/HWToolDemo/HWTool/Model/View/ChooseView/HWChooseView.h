//
//  HWChooseView.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/27.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIView+HW.h"
typedef void(^BaseBlock)(id);
@interface HWChooseView : UIView

@property (nonatomic, assign)BOOL *isChoose;
@property (nonatomic, strong)UIImageView *chooseImageView;
@property (nonatomic, strong)UILabel *statusLabel;
@property (copy, nonatomic)BaseBlock buttonBlock;
@property (copy, nonatomic)BaseBlock viewBlock;
@end
