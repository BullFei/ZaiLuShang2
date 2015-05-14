//
//  Section2Cell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Section2Cell : UITableViewCell
+(Section2Cell *)getSection2ViewWithTableView:(UITableView *)tableview;
@property (nonatomic,weak)NSArray * Section2ItemModelArray;
@end
