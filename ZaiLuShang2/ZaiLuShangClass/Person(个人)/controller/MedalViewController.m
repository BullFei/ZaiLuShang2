//
//  MedalViewController.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MedalViewController.h"
#import "MBProgressHUD+MJ.h"

#define LYZLS_MEDAL_URL @"http://www.117go.com/app/mymedals?touserid=%@&token=35e49d0b0a2ace978e30bb1acaa7684b&v=a6.2.0&vc=yingyb&vd=63f8563b8e3d7949&userid=%@"

@interface MedalViewController ()<UIWebViewDelegate>
{
    UIWebView *_wv;
}
@end

@implementation MedalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebView];
}

- (void)createWebView {
    _wv = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _wv.delegate = self;
    [self.view addSubview:_wv];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:LYZLS_MEDAL_URL, self.userid, self.userid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wv loadRequest:request];
//    [MBProgressHUD showMessage:@"正在加载数据"];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [MBProgressHUD hideHUD];
}
@end
