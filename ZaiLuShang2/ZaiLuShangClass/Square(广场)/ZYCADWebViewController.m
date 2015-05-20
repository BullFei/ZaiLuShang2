//
//  ZYCADWebViewController.m
//  ZaiLuShang2
//
//  Created by qianfengLQL on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCADWebViewController.h"
//#import "Header.h"
@interface ZYCADWebViewController ()

@end

@implementation ZYCADWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    UIWebView * wv =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGW(self.view), CGH(self.view)-64)];
    [wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.ADWebUrl]]];
    wv.scalesPageToFit =YES;
    [self.view addSubview:wv];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
