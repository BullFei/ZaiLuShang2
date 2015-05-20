//
//  SFProductCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchModel,SFProductCell;
@protocol SFProductCellDelegate <NSObject>

-(void)productCell:(SFProductCell *)cell pushController:(UIViewController *)controller;

@end

@interface SFProductCell : UITableViewCell
@property (nonatomic,strong) SFSearchModel * searchModel;
@property (nonatomic,assign)id<SFProductCellDelegate> delegate;
+(SFProductCell *)cellWithTableView:(UITableView *)tableView;
@end
