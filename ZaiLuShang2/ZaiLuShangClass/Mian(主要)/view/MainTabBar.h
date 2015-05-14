//
//  MainTabBar.h
//  YouQuLai
//
//  Created by gaocaixin on 15/4/13.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTabBarDelegate <NSObject>

- (void)tabBarItemButtenClicked:(NSInteger)index;

@end

@interface MainTabBar : UIView

@property (nonatomic ,weak) id<MainTabBarDelegate> delegate;

- (void)addMainTabBarItem:(UITabBarItem *)item;

@end
