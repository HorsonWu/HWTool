//
//  UIButton+HW.m
//  HWToolDemo
//
//  Created by HorsonWu on 2017/3/20.
//  Copyright © 2017年 elovega. All rights reserved.
//

#import "UIButton+HW.h"
#import <objc/runtime.h>
#define defaultInterval 1  //默认时间间隔
@interface UIButton ()

/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (HW)

static const char *UIControl_eventTimeInterval = "UIControl_eventTimeInterval";
static const char *UIControl_enventIsIgnoreEvent = "UIControl_enventIsIgnoreEvent";


// runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent
{
    objc_setAssociatedObject(self, UIControl_enventIsIgnoreEvent, @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, UIControl_enventIsIgnoreEvent) boolValue];
}

- (NSTimeInterval)eventTimeInterval
{
    return [objc_getAssociatedObject(self, UIControl_eventTimeInterval) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval
{
    objc_setAssociatedObject(self, UIControl_eventTimeInterval, @(eventTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    // Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(_hw_sendAction:to:forEvent:);
        Method methodA = class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (void)_hw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    self.eventTimeInterval = self.eventTimeInterval == 0 ? defaultInterval : self.eventTimeInterval;
    if (self.isIgnoreEvent){
        return;
    }else if (self.eventTimeInterval > 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
            
        });
    }
    self.isIgnoreEvent = YES;
    [self _hw_sendAction:action to:target forEvent:event];
}
/*
 ************************************************************
 */

/*
 * 按钮： 背景为指定颜色，圆角
 */
+ (UIButton *)createColorButtonWithFrame:(CGRect)frame Title:(NSString *)title Color:(UIColor *)color Target:(id)target Selector:(SEL)selector {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.backgroundColor = color;
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/*
 * 按钮： 内容可拉伸，而边角不拉伸的图片做背景图片，高度为图片高度
 */
+ (UIButton *)createResizedButtonWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString*)image Target:(id)target Selector:(SEL)selector {
    
    //读取图片
    UIImage * img = [UIImage imageNamed:image];
    
    //设置frame
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    frame.size.height = img.size.height;
    [button setFrame:frame];
    
    //设置背景
    UIImage * resizedImg = [[UIImage imageNamed:image] stretchableImageWithLeftCapWidth:img.size.width / 2 topCapHeight:img.size.height / 2];
    //    UIImage * resizedImg = [[UIImage imageNamed:image] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [button setBackgroundImage:resizedImg forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*
 * 按钮：图片、高亮图片、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed;
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imagePressed] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*
 * 按钮： 背景图片、高亮图片、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector ForgroundImage:(NSString*)image ForgroundImageSelected:(NSString *)imageSelected {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*
 * 按钮：图片、选中图片、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString *)imageSelected {
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

/*
 * 按钮：标题、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/*
 * 按钮：标题、字体、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title FontSize:(CGFloat)fontSize Target:(id)target Selector:(SEL)selector {
    
    UIButton * button = [[self class]createButtonWithFrame:frame Title:title Target:target Selector:selector];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}

/*
 * 按钮：标题、字体、颜色、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title FontSize:(CGFloat)fontSize Color:(UIColor *)color Target:(id)target Selector:(SEL)selector {
    
    UIButton * button = [[self class]createButtonWithFrame:frame Title:title FontSize:fontSize Target:target Selector:selector];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

/*
 * 按钮：标题、字体、颜色、背景图片、动作
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title FontSize:(CGFloat)fontSize Color:(UIColor *)color BgImage:(NSString*)bgImage Target:(id)target Selector:(SEL)selector {
    
    UIButton * button = [[self class]createButtonWithFrame:frame Title:title FontSize:fontSize Color:color Target:target Selector:selector];
    [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return button;
}

@end
