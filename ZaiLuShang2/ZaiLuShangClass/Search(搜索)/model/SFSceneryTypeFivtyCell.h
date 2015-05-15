//
//  SFSceneryTypeFivtyCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel,SFSceneryTypeFivtyCell;

@protocol SFSceneryTypeFivtyCellDelegate <NSObject>

-(void)sceneryTypeFivtyCell:(SFSceneryTypeFivtyCell *)cell pushController:(UIViewController *)controller;

@end
@interface SFSceneryTypeFivtyCell : UITableViewCell
@property (nonatomic,strong) SFSearchModel * searchModel;
@property (nonatomic,assign) id<SFSceneryTypeFivtyCellDelegate> delegate;
+(SFSceneryTypeFivtyCell *)cellWthTableView:(UITableView *)tableView;
@end
