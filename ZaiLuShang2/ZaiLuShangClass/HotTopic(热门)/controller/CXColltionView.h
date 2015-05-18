//
//  CXColltionView.h
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RequestTool.h"
#import "CXCollectionVCell.h"
#import "CXCollectViewCellModel.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "CXPhotoVC.h"
#import "MJRefresh.h"
@class MJRefreshFooterView;
@class MJRefreshHeaderView;

@interface CXColltionView : UIViewController

@property (nonatomic ,weak) UICollectionView *collectionView;

@property (nonatomic ,weak) MJRefreshHeaderView *header;
@property (nonatomic ,weak) MJRefreshFooterView *footer;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *otherUrl;

@property (nonatomic ,strong) NSMutableArray *dataArr;


- (void)requestDataSuccess:(void (^)(id responseObject))success failure:(void (^)())failure;

@end
