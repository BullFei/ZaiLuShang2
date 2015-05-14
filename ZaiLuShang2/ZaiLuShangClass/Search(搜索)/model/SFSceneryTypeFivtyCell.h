//
//  SFSceneryTypeFivtyCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel;
@interface SFSceneryTypeFivtyCell : UITableViewCell
@property (nonatomic,strong) SFSearchModel * searchModel;

+(SFSceneryTypeFivtyCell *)cellWthTableView:(UITableView *)tableView;
@end
