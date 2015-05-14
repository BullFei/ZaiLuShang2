//
//  SFProductCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel;
@interface SFProductCell : UITableViewCell
@property (nonatomic,strong) SFSearchModel * searchModel;
+(SFProductCell *)cellWithTableView:(UITableView *)tableView;
@end
