//
//  CXPhotoVC.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXPhotoVC.h"
#import "CXscrollView.h"
#import "CXCmtVC.h"
#import "LoginVC.h"

#define BOTTEM_HEIGHT 49

@interface CXPhotoVC () <CXscrollViewDelegate>
@property (nonatomic ,weak) UIView *scrollView;
@end

@implementation CXPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor blackColor];
    CXscrollView *view = [[CXscrollView alloc] initWithFrame:CGRectMake(0, 0, CGW(self.view), CGH(self.view))];
    [view setImageUrlNames:self.dataArr index:self.indexPath];
//    view.backgroundColor = [UIColor blueColor];
    view.delegate = self;
    self.scrollView = view;
    [self.view addSubview:view];
}

- (void)scrollViweBarCmtButtenClick:(CXCollectionVCellModel *)model
{
//    CXCmtVC *vc = [[CXCmtVC alloc] init];
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:YES];
    LoginVC *vc = [[LoginVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews[0] setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews[0] setHidden:NO];
    
}
@end
