//
//  UIViewController+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "UIViewController+HW.h"

@implementation UIViewController (HW)
-(void)showProgressView:(UIView *)view customView:(UIView *)customView progressHUDMode:(MBProgressHUDMode)mode bgColor:(UIColor *)color{
    MBProgressHUD *hudNew = [MBProgressHUD showHUDAddedTo:view
                                                 animated:YES];
    [hudNew setMode:mode];
    [hudNew setCustomView:customView];
    [hudNew setColor:color];
}


-(void)hideProgressView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

-(void)createBackButton{
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    
    [backItem setBackButtonBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationItem.backBarButtonItem=backItem;
}

@end
