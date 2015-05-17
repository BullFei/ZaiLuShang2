//
//  CXNewFeature.m
//  CXWeibo
//
//  Created by mac on 15-2-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXNewFeature.h"
#import "MainTabBarController.h"

#define ImageCount 4

@interface CXNewFeature () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *page;

@end

@implementation CXNewFeature

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setupScroll];
    
    [self setupPage];
    
}

- (void)setupPage
{
    CGFloat W = 0;
    CGFloat H = 0;
    CGFloat X = self.view.bounds.size.width/2 - W/2;
    CGFloat Y = self.view.bounds.size.height - 20;

    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    page.numberOfPages = ImageCount;
    page.userInteractionEnabled = NO;
    [self.view addSubview:page];
    self.page = page;
}

- (void)setupScroll
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    
    for (int i = 0; i < ImageCount; i++) {
        NSString *imageName;
        
        imageName = [NSString stringWithFormat:@"5S开机引导-%d", i+1];
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        
        
        imageView.frame = CGRectMake(i * imageW, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        if (i == ImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * ImageCount, imageH);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
}

- (void)setupLastImageView:(UIImageView *)imageView
{

    UIButton *btn = [[UIButton alloc] init];
    btn.frame = self.view.bounds;
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
}
/**
 *  开始
 */
- (void)btn
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[MainTabBarController alloc] init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = (scrollView.contentOffset.x +self.view.bounds.size.width / 2) / self.view.bounds.size.width;
}

@end
