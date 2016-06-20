//
//  HWViewTool.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWViewTool.h"

@implementation HWViewTool
#pragma mark -- 设置controller的NavigationTiltleView
+(void)loadNavigationTiltleViewWithTitle:(NSString*)titleName  image:(NSString*)imageName forController:(UIViewController*)controller
{
    controller.view.backgroundColor=UIColorFromRGB(0xEBEBEB,1.0);
    //    [controller.navigationController.navigationBar setBarTintColor:MainColor];
    if (titleName==nil) {
        return;
    }
    UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    titleLabel.text=titleName;
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.textColor = [UIColor whiteColor];
    controller.navigationItem.titleView=titleLabel;
}
#pragma mark -- 生成导航栏返回按钮
+ (void)createNavBackItem:(NSString *)imageName andController:(UIViewController *)viewController
{
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    viewController.navigationController.navigationBar.tintColor = [UIColor clearColor];
    viewController.navigationItem.backBarButtonItem=backItem;
}
#pragma mark -- 生成导航栏左按钮
+ (void)createNavLeftButton:(NSString *)title WithImage:(NSString *)imageName WithController:(UIViewController *)viewController withTarget:(id)target withAction:(SEL)action
{
    
    if (imageName ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:imageName];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        leftItem.title=@"";
        viewController.navigationItem.leftBarButtonItem=leftItem;
    }else{
        UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
        leftItem.tintColor = [UIColor whiteColor];
        viewController.navigationItem.rightBarButtonItem=leftItem;
    }
    
    
    
}
#pragma mark -- 生成导航栏右按钮
+ (void)createNavRightButton:(NSString *)title WithImage:(NSString *)imageName WithController:(UIViewController *)viewController withTarget:(id)target withAction:(SEL)action
{
    
    if (imageName) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:imageName];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        rightItem.title=@"";
        viewController.navigationItem.rightBarButtonItem=rightItem;
    }else{
        UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
        rightItem.tintColor = [UIColor whiteColor];
        viewController.navigationItem.rightBarButtonItem=rightItem;
    }
    
    
    
}
#pragma mark -- 根据label的内容，计算label的自适应高度
+(void)getSizeByLabel:(UILabel*)label andTheLabelWidth:(int)width{
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName,nil];
    CGSize  autoSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, autoSize.width, autoSize.height);
}


#pragma mark -- 将方形图片裁剪成圆形的

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

#pragma mark -- 对图片尺寸进行压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    
    return newImage;
    
    
}
#pragma mark -- 改变图片的背景颜色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}
#pragma mark -- 创建一个alertView
+(UIAlertView *)infoViewShowWithString:(NSString *)string
{
    UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:nil message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alerView show];
    
    return alerView;
}

#pragma mark --------------------------------- 提示 -------------------------------
+(void)showReminderMessage:(NSString *)message addToView:(UIView *)view hideAfterDelay:(NSTimeInterval)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}

@end
