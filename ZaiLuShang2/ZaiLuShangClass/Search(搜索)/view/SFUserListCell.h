//
//  SFUserListCell.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHeadTipUser;
@interface SFUserListCell : UITableViewCell
@property (nonatomic,strong) SFCityTypeHeadTipUser * user;
+(SFUserListCell *)cellWithTableView:(UITableView *)tableView;
@end
