//
//  HWQRCodeUtil.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/7/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "HWQRCodeUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface HWQRCodeUtil ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) completeBlock handle;
@property (nonatomic, strong) AVCaptureDevice * device;
@property (nonatomic, strong) AVCaptureDeviceInput * input;
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property (nonatomic, strong) UIView * previewBorder;
@property (nonatomic, strong) UIImageView *scanImageView;

@end
@implementation HWQRCodeUtil
- (instancetype)initWithHandle:(completeBlock)handle {
    if (self = [super init]) {
        self.handle = handle;
        [self configPreview];
        [self configCamera];
    }
    return self;
}

- (void)configPreview {
    self.preview = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
}

- (void)configCamera {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //
    self.session = [[AVCaptureSession alloc]init];
    //输入图片质量大小，要保证较小的二维码图片能快速扫描，最好设置1080p
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    //条码类型
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code]];
    //
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = SCREEN_BOUNDS;
    [self.preview.layer insertSublayer:self.previewLayer atIndex:0];
}

- (void)setScanZone:(CGRect)scanZone {
    //    _scanZone = scanZone;
    //设置区域原点在右上角，XY互换，WH互换 CGRectMake(Y, X, H, W)
    [self.output setRectOfInterest:CGRectMake(scanZone.origin.y, 0, 0.5, 1)];
}

- (void)setScanWidth:(CGFloat)scanWidth {
    if (scanWidth > SCREEN_WIDTH) {
        scanWidth = SCREEN_WIDTH;
    }
    _scanWidth = scanWidth;
    //添加遮罩层
    [self addMaskWithFrame:CGRectMake((SCREEN_WIDTH - scanWidth) / 2, (SCREEN_HEIGHT - scanWidth) / 2, scanWidth, scanWidth)];
    //设置区域原点在右上角，XY互换，WH互换 CGRectMake(Y, X, H, W)
    [self.output setRectOfInterest:CGRectMake(self.previewBorder.frame.origin.y / SCREEN_HEIGHT, self.previewBorder.frame.origin.x / SCREEN_WIDTH, scanWidth / SCREEN_HEIGHT, scanWidth / SCREEN_WIDTH)];
}

#pragma mark - 添加遮罩层
- (void)addMaskWithFrame:(CGRect)frame {
    //
    self.previewBorder = [[UIView alloc]initWithFrame:frame];
    self.previewBorder.backgroundColor = [UIColor clearColor];
    //self.previewBorder.layer.borderColor = BaseColor.CGColor;
    self.previewBorder.layer.borderWidth = 2.0;
    [self.preview addSubview:self.previewBorder];
    
    
    self.scanImageView = [[UIImageView alloc] initWithFrame:frame];
    self.scanImageView.hidden = YES;
    [self.preview addSubview:self.scanImageView];
    //
    UILabel * hint = [[UILabel alloc]initWithFrame:CGRectMake(0, self.previewBorder.frame.origin.y + self.previewBorder.frame.size.height + 10, SCREEN_WIDTH, 20)];
    hint.text = @"将二维码放入框内，即可自动扫描";
    hint.font = [UIFont systemFontOfSize:16.0];
    hint.textColor = [UIColor whiteColor];
    hint.textAlignment = NSTextAlignmentCenter;
    [self.preview addSubview:hint];
    //
    UIButton * lightBtn = [[UIButton alloc]init];
    lightBtn.frame = CGRectMake((SCREEN_WIDTH - 160)/2, hint.frame.origin.y + 30, 65, 97);
    [lightBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [lightBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateHighlighted];
    [lightBtn addTarget:self action:@selector(openOrCloseLight) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:lightBtn];
    //
    UIButton * photoBtn = [[UIButton alloc]init];
    photoBtn.frame = CGRectMake(lightBtn.frame.origin.x + lightBtn.frame.size.width + 30, lightBtn.frame.origin.y, 65, 97);
    [photoBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.preview addSubview:photoBtn];
    //
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:SCREEN_BOUNDS cornerRadius:0.f];
    UIBezierPath * scanPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:0.f];
    [maskPath appendPath:scanPath];
    [maskPath setUsesEvenOddFillRule:YES]; //使用填充规则
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.opacity = 0.65;
    [self.preview.layer insertSublayer:maskLayer above:self.previewLayer];
}

#pragma mark - action
- (void)startScaning {
    if (!self.session.isRunning) {
        [self.session startRunning];
    }
}

- (void)stopScaning {
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}

#pragma mark - delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self stopScaning];
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.lastObject;
        NSString * codeString = metadataObject.stringValue;
        if (self.handle) {
            self.handle(codeString);
        }
    }
}

#pragma mark -- 打开相册
- (void)openPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    
    picker.allowsEditing = YES;
    
    
    [[HWFuntion getCurrentVC] presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.scanImageView.image = image;
    self.scanImageView.hidden = NO;
    //系统自带识别方法
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count > 0)
    {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scanResult = feature.messageString;
        
        NSLog(@"%@",scanResult);
        
        if (self.handle) {
            self.handle(scanResult);
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 打开或关闭灯光
- (void)openOrCloseLight {
    AVCaptureDevice *device =  [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch] && [device hasFlash])
    {
        AVCaptureTorchMode torch = self.input.device.torchMode;
        
        switch (_input.device.torchMode) {
            case AVCaptureTorchModeAuto:
                break;
            case AVCaptureTorchModeOff:
                torch = AVCaptureTorchModeOn;
                break;
            case AVCaptureTorchModeOn:
                torch = AVCaptureTorchModeOff;
                break;
            default:
                break;
        }
        
        [_input.device lockForConfiguration:nil];
        _input.device.torchMode = torch;
        [_input.device unlockForConfiguration];
        
    }
}

@end
