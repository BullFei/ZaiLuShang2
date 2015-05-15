//
//  CXCmtCell.h
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXCmtFrameModel;

@interface CXCmtCell : UITableViewCell

@property (nonatomic ,strong) CXCmtFrameModel *model;

+ (CXCmtCell *)cmtCellWithTableView:(UITableView *)tableView;
@end
