//
//  HotTopicVC.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotTopicVC.h"
#import "RequestTool.h"
#import "MJExtension.h"
#import "CXCollectionVCellModel.h"
#import "CXCollectionVCellOwnerModel.h"
#import "CXCollectViewCellModel.h"
#import "MJRefresh.h"

@interface HotTopicVC ()

@end

@implementation HotTopicVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.url = @"http://app6.117go.com/demo27/php/plaza.php?submit=getPlazaPics&length=18&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0";
}




@end
