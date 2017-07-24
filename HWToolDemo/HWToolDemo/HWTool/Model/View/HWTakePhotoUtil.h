//
//  HWTakePhotoUtil.h
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^TakePhotoHandleBlock)();  //上传照片后的回调方法

typedef void(^DeletePhotoHandleBlock)();  //删除照片后的回调方法
@interface HWTakePhotoUtil : NSObject
@property (nonatomic, strong) NSMutableArray * imgFiles; //图片文件的数组
@property (nonatomic, strong) NSMutableArray * imgUrlArray; //图片的url数组
@property (nonatomic, strong) NSMutableArray * ivArray; //图片的数组
@property (nonatomic, strong) NSMutableArray * btnArray; //按钮的数组

@property (copy, nonatomic) TakePhotoHandleBlock takePhotoBlock;
@property (copy, nonatomic) DeletePhotoHandleBlock deletePhotoBlock;

- (instancetype)initWithController:(UIViewController *)controller
                     takePhotoView:(UIImageView *)imageView
                        imageFiles:(NSMutableArray *)imgFiles
                     imageUrlArray:(NSMutableArray *)imgUrlArray
                           ivArray:(NSMutableArray *)ivArray
                          btnArray:(NSMutableArray *)btnArray;
- (void)takePhoto;

@end
