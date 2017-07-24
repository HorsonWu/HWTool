//
//  UIViewController+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIViewController+HW.h"

@implementation UIViewController (HW)
#pragma mark -- 设置导航栏颜色和导航栏的字体颜色
-(void)setThemeWithBarColor:(UIColor *)barColor fontColor:(UIColor *)fontColor
{
    self.navigationController.navigationBar.tintColor = fontColor;
    self.navigationController.navigationBar.barTintColor = barColor;
} 

#pragma mark -- 设置Tiltle
-(void)setTitle:(NSString*)titleName
{
    UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    titleLabel.text=titleName;
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView=titleLabel;
}
#pragma mark -- 自定义返回按钮（文字）
-(void)setBackButtonWithText:(NSString *)backText
{
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
    backItem.title=backText;
    [backItem setBackButtonBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem=backItem;
}

#pragma mark -- 自定义返回按钮（图片）
-(void)setBackButtonWithImage:(UIImage *)image
{
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    [backItem setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem=backItem;
}

#pragma mark -- 自定义导航栏左按钮（图片）
- (void)setNavLeftItemWithImage:(UIImage *)image selector:(SEL)selector
{
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    leftItem.title=@"";
    self.navigationItem.leftBarButtonItem=leftItem;
}
#pragma mark -- 自定义导航栏左按钮（文字）
- (void)setNavLeftItemWithTitle:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.leftBarButtonItem=leftItem;
}

#pragma mark -- 自定义导航栏右按钮（图片）
- (void)setNavRightItemWithImage:(UIImage *)image selector:(SEL)selector
{
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    leftItem.title=@"";
    self.navigationItem.rightBarButtonItem=leftItem;
}
#pragma mark -- 自定义导航栏右按钮（文字）
- (void)setNavRightItemWithTitle:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem=leftItem;
}

@end
