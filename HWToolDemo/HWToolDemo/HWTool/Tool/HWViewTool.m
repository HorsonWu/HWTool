//
//  HWViewTool.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/15.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWViewTool.h"

@implementation HWViewTool

#pragma mark -- 根据label的内容，计算label的自适应高度
+(void)getSizeByLabel:(UILabel*)label andTheLabelWidth:(int)width{
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName,nil];
    CGSize  autoSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, autoSize.width, autoSize.height);
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

    
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    //如果是Nav
    if ([result isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)result;
        return nav.topViewController;
    }
    
    return result;
}

+ (void)cleanKeywindow {
    NSArray * views = [UIApplication sharedApplication].keyWindow.subviews;
    if (views.count == 1) {
        return;
    }
    for (NSInteger i = 1; i < views.count; i ++) {
        [views[i] removeFromSuperview];
    }
}

@end
