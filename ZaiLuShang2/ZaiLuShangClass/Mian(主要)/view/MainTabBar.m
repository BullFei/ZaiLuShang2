//
//  MainTabBar.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/13.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButten.h"

@interface MainTabBar ()

@property (nonatomic ,strong) NSMutableArray *itemArray;

@property (nonatomic ,strong) MainTabBarButten *tempBtn;

@property (nonatomic ,weak) UIImageView *bgImageView;

@end

@implementation MainTabBar

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"foot_bg"];
        self.bgImageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

- (void)addMainTabBarItem:(UITabBarItem *)item
{
    MainTabBarButten *btn = [[MainTabBarButten alloc] init];
    [btn addTarget:self action:@selector(btnItemClick:) forControlEvents:UIControlEventTouchDown];
    btn.item = item;
    [self addSubview:btn];
    [self.itemArray addObject:btn];
    
    if (self.itemArray.count == 1) {
        [self btnItemClick:btn];
    }
}


- (void)btnItemClick:(MainTabBarButten *)btn
{
    self.tempBtn.selected = NO;
    btn.selected = YES;
    self.tempBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(tabBarItemButtenClicked:)]) {
        [self.delegate tabBarItemButtenClicked:btn.tag];
    } else {
        NSLog(@"没有tabBarItemButtenClicked方法");
    }
}

- (void)layoutSubviews
{
    CGFloat itemW = CGW(self) / self.itemArray.count;
    for (int i = 0; i < self.itemArray.count; i++) {
        MainTabBarButten *btn = (MainTabBarButten *)self.itemArray[i];
        btn.tag = i;
        btn.frame = CGRectMake(i*itemW, 0, itemW, CGH(self));
    }
    CGFloat pianyi = 10;
    self.bgImageView.frame = CGRectMake(0, 0 - pianyi, CGW(self), CGH(self) + pianyi);
}

@end
