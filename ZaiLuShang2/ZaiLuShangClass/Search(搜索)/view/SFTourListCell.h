//
//  SFTourListCell.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFTour;
@interface SFTourListCell : UITableViewCell
+(SFTourListCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) SFTour * tour;

@end
