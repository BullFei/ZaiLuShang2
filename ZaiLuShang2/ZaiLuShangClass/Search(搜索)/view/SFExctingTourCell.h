//
//  SFExctingTourCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel,SFExctingTourCell;
@protocol SFExctingTourCellDelegate <NSObject>

-(void)exctingTourCell:(SFExctingTourCell *)cell pushController:(UIViewController *)controller;

-(void)iconPushController:(UIViewController *)controller;

@end
@interface SFExctingTourCell : UITableViewCell
+(SFExctingTourCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,assign) id<SFExctingTourCellDelegate> delegate;
@property (nonatomic,strong) SFSearchModel * searchModel;

@end
