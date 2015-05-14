//
//  SFSceneryCellTableViewCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchDisplayModule,SFSceneryCellTableViewCell;
@protocol SFSceneryCellTableViewCellDelegate <NSObject>

-(void)sceneryCellTableViewCellPushController:(SFSceneryCellTableViewCell *)sceneryCellTableViewCell withSearchDisplayModule:(SFSearchDisplayModule *)searchModule;

@end

@interface SFSceneryCellTableViewCell : UITableViewCell

@property (nonatomic,strong) SFSearchDisplayModule * displayModuleLeft;
@property (nonatomic,strong) SFSearchDisplayModule * displayModuleRight;

@property (nonatomic,assign) id<SFSceneryCellTableViewCellDelegate> deleagte;
+(SFSceneryCellTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
