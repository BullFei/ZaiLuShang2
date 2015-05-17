//
//  MainNavigationC.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/13.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import "MainNavigationC.h"

@interface MainNavigationC ()

@end

@implementation MainNavigationC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.navigationBar.backgroundColor = [UIColor blueColor];
    
//    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        // 隐藏tabbar
        self.tabBarController.tabBar.hidden = YES;
        // 自定义back
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(00, 0, 40, 30)];
        btn.backgroundColor = CXColorP(100, 100, 100, 1);
        [btn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        // 隐藏nav
//        [self.navigationBar.subviews[0] setHidden:YES];
    }
}
// 返回
- (void)back
{
    [self popViewControllerAnimated:YES];
    if (self.viewControllers.count < 2) {
        [self.navigationBar.subviews[0] setHidden:NO];
        self.tabBarController.tabBar.hidden = NO;
    }
}

@end
