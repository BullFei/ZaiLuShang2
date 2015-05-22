//
//  SFSearchCountryCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchCountryCell,SFSearchDisplayModule;
@protocol SFSearchCountryCellDelegate <NSObject>

-(void)searchCountryCellPushController:(SFSearchCountryCell *)searchCountryCell withSearchDisplayModule:(SFSearchDisplayModule *)searchModule;

@end
@interface SFSearchCountryCell : UITableViewCell
@property (nonatomic,strong) SFSearchDisplayModule * displayModuleLeft;
@property (nonatomic,strong) SFSearchDisplayModule * displayModuleRight;

@property (nonatomic,assign) id<SFSearchCountryCellDelegate> delegate;

+(SFSearchCountryCell *)cellWithTableView:(UITableView *)tableView;
@end
