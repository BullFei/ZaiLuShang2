//
//  SFCityWantedCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHead,SFSceneryObjModel;

@interface SFCityWantedCell : UITableViewCell

@property (nonatomic,strong) SFCityTypeHead * cityTypeHead;
@property (nonatomic,strong) SFSceneryObjModel * sceneryObjModel;
+(SFCityWantedCell *)cellWithTableView:(UITableView *)tableView;
@end
