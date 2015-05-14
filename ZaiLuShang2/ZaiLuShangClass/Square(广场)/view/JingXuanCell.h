//
//  JingXuanCell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingXuanModel.h"
@interface JingXuanCell : UITableViewCell
+(JingXuanCell *)GetJingXuanCellWithTableView:(UITableView *)tableview;
@property (nonatomic,weak)JingXuanModel * jingXuanModel;
@end
