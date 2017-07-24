//
//  HWPhotoBrowserConfig.h
//  WanZhongLife
//
//  Created by HorsonWu on 16/5/25.
//  Copyright © 2016年 com.revenco.company. All rights reserved.
//

#ifndef HWPhotoBrowserConfig_h
#define HWPhotoBrowserConfig_h

typedef enum {
    HWWaitingViewModeLoopDiagram, // 环形
    HWWaitingViewModePieDiagram // 饼型
} HWWaitingViewMode;


// browser背景颜色
#define HWPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

// browser中图片间的margin
#define HWPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define HWPhotoBrowserShowImageAnimationDuration 0.4f

// browser中显示图片动画时长
#define HWPhotoBrowserHideImageAnimationDuration 0.4f

// 图片下载进度指示进度显示样式（HWWaitingViewModeLoopDiagram 环形，HWWaitingViewModePieDiagram 饼型）
#define HWWaitingViewProgressMode HWWaitingViewModeLoopDiagram

// 图片下载进度指示器背景色
#define HWWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define HWWaitingViewItemMargin 10


#endif /* HWPhotoBrowserConfig_h */
