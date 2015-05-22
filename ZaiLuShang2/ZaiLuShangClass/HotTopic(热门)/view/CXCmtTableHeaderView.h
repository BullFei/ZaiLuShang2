//
//  CXCmtTableHeaderView.h
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXCollectionVCellModel;

@interface CXCmtTableHeaderView : UIView

+ (CXCmtTableHeaderView *)tableHeaderView;

@property (nonatomic ,strong) CXCollectionVCellModel *model;

@end
