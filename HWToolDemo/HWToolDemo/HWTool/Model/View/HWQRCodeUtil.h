//
//  HWQRCodeUtil.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//
/*
 * 使用：
 self.codeUtil = [[WZQRCodeUtil alloc]initWithHandle:^(NSString *codeString) {
 WZLog(@"%@", codeString);
 }];
 //默认全屏，若要指定区域，设置scanWidth
 self.codeUtil.scanWidth = 250;
 [self.view addSubview:self.codeUtil.preview];
 [self.codeUtil startScaning];
 
 扫描成功后自动停止，若要重新扫描：
 [self.codeUtil startScaning];
 */

#import <Foundation/Foundation.h>
typedef void(^completeBlock)(NSString *codeString);

@interface HWQRCodeUtil : NSObject
@property (nonatomic, strong) UIView * preview; //默认屏幕大小
@property (nonatomic, assign) CGFloat scanWidth; //指定扫描区域边长

- (instancetype)initWithHandle:(completeBlock)handle;
- (void)startScaning;
- (void)stopScaning;
@end
