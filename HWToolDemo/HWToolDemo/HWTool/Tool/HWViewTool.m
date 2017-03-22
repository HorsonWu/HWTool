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

@end
