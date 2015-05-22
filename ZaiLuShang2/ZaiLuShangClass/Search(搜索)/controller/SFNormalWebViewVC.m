//
//  SFNormalWebViewVC.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFNormalWebViewVC.h"

@interface SFNormalWebViewVC ()

@end

@implementation SFNormalWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.message;
    [self createUI];
}

-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView setUserInteractionEnabled:YES];
    [webView setOpaque:YES];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
     
    //self.navigationController.navigationBar.translucent=YES;
    
}


@end
