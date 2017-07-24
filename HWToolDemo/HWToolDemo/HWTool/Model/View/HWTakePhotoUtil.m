//
//  HWTakePhotoUtil.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWTakePhotoUtil.h"
@interface HWTakePhotoUtil ()
<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController * currectController;
@property (nonatomic, strong) UIImageView * takePhotoImageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end
@implementation HWTakePhotoUtil

- (instancetype)initWithController:(UIViewController *)controller
                     takePhotoView:(UIImageView *)imageView
                        imageFiles:(NSMutableArray *)imgFiles
                     imageUrlArray:(NSMutableArray *)imgUrlArray
                           ivArray:(NSMutableArray *)ivArray
                          btnArray:(NSMutableArray *)btnArray
{
    if (self = [super init]) {
        self.currectController = controller;
        self.takePhotoImageView = imageView;
        self.imgFiles = imgFiles;
        self.imgUrlArray = imgUrlArray;
        self.ivArray = ivArray;
        self.btnArray = btnArray;
        [self loadThePicture];
    }
    return self;
    
}


- (void)loadThePicture {
    //没有照片时，直接返回
    if (self.imgUrlArray.count == 0) {
        return;
    }
    
    
    //有照片时，先填充照片，再对照片组的位置进行处理
    
    CGFloat left = self.takePhotoImageView.frame.origin.x;
    CGFloat top = self.takePhotoImageView.frame.origin.y;
    CGFloat width = self.takePhotoImageView.frame.size.width;
    CGFloat height = self.takePhotoImageView.frame.size.height;
    
    CGFloat delBtnWidth = width/5;
    
    for (NSInteger i = 0; i < self.imgUrlArray.count; i++) {
        
        UIImageView * view = [UIImageView new];
        [view sd_setImageWithURL:[NSURL URLWithString:self.imgUrlArray[i]] placeholderImage:DefaultImg];
        view.frame = CGRectMake(left + (width + 10) * i, top, width, height);
        [_ivArray addObject:view];
        
        UIImage *image = view.image;
        if (image) {
            NSData * data = UIImageJPEGRepresentation(image, 0.5);
            [_imgFiles addObject:data];
        }
        
        UIButton *btn = [SuButton createButtonWithFrame:CGRectMake(0, 0, delBtnWidth, delBtnWidth) Target:self Selector:@selector(removeImg:) Image:@"button_close_nor" ImagePressed:nil];
        btn.center = CGPointMake(view.x + view.w - delBtnWidth/2, view.y + delBtnWidth/2);
        btn.tag = i ;
        [_btnArray addObject:btn];
        
        [self.takePhotoImageView.superview addSubview:view];
        [self.takePhotoImageView.superview addSubview:btn];
        
    }
    self.takePhotoImageView.frame = CGRectMake( left + (width + 10) * _ivArray.count, top, width, height);
    self.takePhotoImageView.userInteractionEnabled = YES;
}

#pragma mark -- 添加图片的处理
- (void)takePhoto {
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [sheet showInView:self.currectController.view];
    
}

#pragma mark - 图片选择
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 0:
            {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
                if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                    NSString *errorStr = @"应用的相机权限受限,请在设置中启用";
                    
                    UIAlertView *alterView =[[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alterView show];
                    
                    return;
                }
                
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
                
                break;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                // 取消
                [self releaseSomeObject];
                return;
                break;
                
        }
        
    }
    else {
        if (buttonIndex == 0) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        } else {
            [self releaseSomeObject];
            return;
        }
    }
    if (!self.imagePickerController) {
        // 跳转到相机或相册页面
        self.imagePickerController = [[UIImagePickerController alloc] init];
        
        self.imagePickerController.delegate = self;
        
        self.imagePickerController.allowsEditing = YES;
        
    }
    
    self.imagePickerController.sourceType = sourceType;
    
    [self.currectController presentViewController:self.imagePickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //编辑后的图片（压缩尺寸）
    UIImage * image = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    
    [_imgFiles addObject:data];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self setImgAndAddNewPicker:image];
        
        if (self.takePhotoBlock) {
            self.takePhotoBlock();
        }
        
        [self releaseSomeObject];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [self releaseSomeObject];
}

#pragma mark - 添加照片后处理
- (void)setImgAndAddNewPicker:(UIImage *)image {
    
    
    
    //1 ------- 添加图片及删除按钮
    UIImageView * iv = [[UIImageView alloc]initWithFrame:self.takePhotoImageView.frame];
    iv.image = image;
    [_ivArray addObject:iv];
    
    CGFloat delBtnWidth = iv.frame.size.width/5;
    
    UIButton * del = [SuButton createButtonWithFrame:CGRectMake(0, 0, delBtnWidth, delBtnWidth) Target:self Selector:@selector(removeImg:) Image:@"button_close_nor" ImagePressed:nil];
    del.tag =  _imgFiles.count-1;
    del.center = CGPointMake(iv.x + iv.w - delBtnWidth/2, iv.y + delBtnWidth/2);
    [_btnArray addObject:del];
    
    [self.takePhotoImageView.superview addSubview:iv];
    [self.takePhotoImageView.superview addSubview:del];
    
    //2 ------- 如果达到3张图，不能继续添加
    if (self.imgFiles.count >= 3) {
        self.takePhotoImageView.userInteractionEnabled = NO;
        return;
    }else {
        self.takePhotoImageView.userInteractionEnabled = YES;
    }
    
    //3 ------- 图片添加框向右移动
    self.takePhotoImageView.frame = CGRectMake(iv.x + iv.w + 10, iv.y, iv.w, iv.h);
    
    
    
}

- (void)removeImg:(UIButton *)btn {
    
    //1 ------- 获取第一张图片的坐标位置
    UIImageView * firstImageView = _ivArray[0];
    CGFloat left = firstImageView.frame.origin.x;
    CGFloat top = firstImageView.frame.origin.y;
    CGFloat width = firstImageView.frame.size.width;
    CGFloat height = firstImageView.frame.size.height;
    
    CGFloat delBtnWidth = width/5;
    //2 ------- 从界面移除点击的图片
    UIImageView * iv = _ivArray[btn.tag];
    [iv removeFromSuperview];
    [btn removeFromSuperview];
    
    //3 ------- 数组内移除相应的元素
    [_ivArray removeObjectAtIndex:btn.tag];
    [_btnArray removeObjectAtIndex:btn.tag];
    [_imgFiles removeObjectAtIndex:btn.tag];
    
    //4 ------- 重新排列图片的位置
    for (NSInteger i = 0; i < _ivArray.count; i++) {
        
        UIImageView * view = _ivArray[i];
        view.frame = CGRectMake( left + (width + 10) * i, top, width, height);
        
        UIButton *btn = _btnArray[i];
        btn.center = CGPointMake(view.x + view.w - delBtnWidth/2, view.y + delBtnWidth/2);
        btn.tag = i ;
    }
    self.takePhotoImageView.frame = CGRectMake( left + (width + 10) * _ivArray.count, top, width, height);
    self.takePhotoImageView.userInteractionEnabled = YES;
    
    if (self.deletePhotoBlock) {
        self.deletePhotoBlock();
    }
    
    [self releaseSomeObject];
}

- (void)releaseSomeObject{
    //    self.takePhotoBlock = nil;
    //    self.deletePhotoBlock = nil;
    //    self.currectController = nil;
}

@end
