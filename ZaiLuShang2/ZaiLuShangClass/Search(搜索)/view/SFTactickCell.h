//
//  SFTactickCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel;
@interface SFTactickCell : UITableViewCell
@property (nonatomic,strong) SFSearchModel * searchModel;
+(SFTactickCell *)cellWithTableView:(UITableView *)tableView;
@end
