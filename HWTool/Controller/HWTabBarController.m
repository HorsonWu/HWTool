//
//  HWTabBarController.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/10/14.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "HWTabBarController.h"

@implementation HWTabBarController
{
    NSMutableArray *_navigationVCArray;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)createControllers
{
   
    _navigationVCArray = [NSMutableArray array];
    
    for (int i = 0 ; i < _viewControllersArray.count; i++) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[_viewControllersArray objectAtIndex:i]];
        
        [_navigationVCArray addObject:navigationController];
    }
    
    self.viewControllers = [NSArray arrayWithArray:_navigationVCArray];
}

- (void)createView
{
    _tabBarView = [[HWTabbarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -60, SCREEN_WIDTH, 60)];
    
    [_tabBarView configureTabbarWithNormalImageArray:_normalImageArray selectImageArray:_selectImageArray tabbarTitleArray:_tabbarTitleArray];
    
    _tabBarView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    _tabBarView.buttonBlock = ^(UIButton *button)
    {
        
        NSUInteger tag = button.tag;
        weakSelf.selectedIndex = tag - 100001;
        
        for (int i = 100001; i < 100001+self.tabbarTitleArray.count; i ++)
        {
            
            UIButton *button = (UIButton *)[weakSelf.view viewWithTag:i];
            button.selected = NO;
        }
        
        button.selected = YES;
    };
    
    [self.view addSubview:_tabBarView];
    
}

- (void)hiddenTabbar
{
    _tabBarView.hidden = YES;
    self.tabBar.hidden = YES;
}

- (void)showTabbar
{
    _tabBarView.hidden = NO;
    self.tabBar.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
