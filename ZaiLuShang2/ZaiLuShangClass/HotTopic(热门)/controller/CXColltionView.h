//
//  CXColltionView.h
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface CXColltionView : UIViewController

@property (nonatomic ,weak) UICollectionView *collectionView;

@property (nonatomic ,weak) MJRefreshHeaderView *header;
@property (nonatomic ,weak) MJRefreshFooterView *footer;

@property (nonatomic, copy) NSString *url;




@end
