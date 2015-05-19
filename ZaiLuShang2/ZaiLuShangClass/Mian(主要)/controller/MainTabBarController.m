//
//  MainTabBarController.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/13.
//  Copyright (c) 2015年 GCX. All rights reserved.
// aa

#import "MainTabBarController.h"
#import "HotTopicVC.h"
#import "PersonVC.h"
#import "SearchVC.h"
#import "SquareVC.h"
#import "MainNavigationC.h"
#import "MainTabBar.h"


@interface MainTabBarController () <MainTabBarDelegate>

@property (nonatomic ,strong) MainTabBar *mainTabBar;


@end

@implementation MainTabBarController

- (MainTabBar *)mainTabBar
{
    if (_mainTabBar == nil) {
        _mainTabBar = [[MainTabBar alloc] init];
        _mainTabBar.frame = self.tabBar.bounds;
        _mainTabBar.delegate = self;
        [self.tabBar addSubview:_mainTabBar];
        
    }
    return _mainTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createVC];
    
}


- (void)createVC
{
    SquareVC *frist = [[SquareVC alloc]init];
    [self addVC:frist title:@"广场" image:@"tab_home_48_off" selImage:@"tab_home_48_on"];
    
    HotTopicVC *second = [[HotTopicVC alloc] init];
    [self addVC:second title:@"热门" image:@"tab_profile_48_off" selImage:@"tab_profile_48_on"];
    
    SearchVC *third = [[SearchVC alloc] init];
    [self addVC:third title:@"发现" image:@"tab_search_48_off" selImage:@"tab_search_48_on"];
    
    PersonVC *fourth = [[PersonVC alloc] init];
    [self addVC:fourth title:@"个人" image:@"tab_feed_48_off" selImage:@"tab_feed_48_on"];
    
    
}

- (void)addVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{

    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    
    MainNavigationC *mnc = [[MainNavigationC alloc] initWithRootViewController:vc];
    [self addChildViewController:mnc];
    
    [self.mainTabBar addMainTabBarItem:vc.tabBarItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            child.alpha = 0;
        }
    }
}

#pragma mark - maintabbar代理
- (void)tabBarItemButtenClicked:(NSInteger)index
{
    self.selectedIndex = index;
}


@end
