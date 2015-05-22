//
//  SFDetailTactickController.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFDetailTactickController.h"
#import "SFSearchModel.h"
#import "SFTactick.h"
@interface SFDetailTactickController ()

@end

@implementation SFDetailTactickController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
}
#pragma mark -创建nav
-(void)createNav{
    self.navigationItem.title = [[self.searchModel.listArray firstObject] title
                                 ];
//    UIButton * moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [moreBtn setImage:[UIImage imageNamed:@"icon_more_white_40"] forState:UIControlStateNormal];
//    UIBarButtonItem * moreItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
//    UIButton * shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [shareBtn setImage:[UIImage imageNamed:@"icon_share_line_white_40"] forState:UIControlStateNormal];
//    UIBarButtonItem * sharItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
//    
//    self.navigationItem.rightBarButtonItems =@[moreItem,sharItem];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
     [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView setUserInteractionEnabled:YES];
    [webView setOpaque:YES];
    [webView setScalesPageToFit:YES];
   // webView.delegate = self;
    SFTactick * tactick =self.searchModel.listArray.firstObject;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tactick.link]]];
    
}

@end
