//
//  UILabel+HW.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "UILabel+HW.h"

@implementation UILabel (HW)
- (CGSize)boundsSize:(CGSize)size
{
    CGSize resSize = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    resSize = [self.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return resSize;
}

@end
