//
//  SFExctingTourCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel;
@interface SFExctingTourCell : UITableViewCell
+(SFExctingTourCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) SFSearchModel * searchModel;

@end
