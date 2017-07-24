//
//  HWNetwokUploadingAnimation.h
//  WanZhongLife
//
//  Created by HorsonWu on 15/11/21.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNetwokUploadingAnimation : NSObject

+ (instancetype)sharedInstance;
//显示动画
- (void)showLoadingAnimationToView:(id)view;
- (void)showAniWithCues:(NSString *)cues toView:(id)view;
- (void)hideAni;
@end
