//
//  LYWebViewController.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYWebViewController.h"
#import "MBProgressHUD+MJ.h"

#define LYZLS_TOUR_URL @"http://www.117go.com/tour/%@"
#define LYZLS_USER_URL @"http://www.117go.com/user/%@"

@interface LYWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_wv;
}
@end

@implementation LYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self addBackButton];
}

- (void)createWebView {
    _wv = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _wv.userInteractionEnabled = YES;
    _wv.delegate = self;
    
    NSURL *url;
    switch (self.pageType) {
        case WebViewPageTypeTour:
            url = [NSURL URLWithString:[NSString stringWithFormat:LYZLS_TOUR_URL, self.tourid]];
            break;
        case WebViewPageTypeUser:
            url = [NSURL URLWithString:[NSString stringWithFormat:LYZLS_USER_URL, self.userid]];
            break;
        default:
            break;
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.view addSubview:_wv];
    [_wv loadRequest:request];
    [MBProgressHUD showMessage:@"正在加载数据"];
}
- (void)addBackButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - webView代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    CXLog(@"%@", request.URL.absoluteString);
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}
@end
