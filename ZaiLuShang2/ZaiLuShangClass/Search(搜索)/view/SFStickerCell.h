//
//  SFStickerCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHead;
@interface SFStickerCell : UITableViewCell

@property (nonatomic,strong) SFCityTypeHead * cityTypeHead;

+(SFStickerCell *)cellWithTableView:(UITableView *)tableView;
@end
