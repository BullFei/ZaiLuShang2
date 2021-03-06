//
//  Section2Cell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Section2ItemModel;

@interface Section2Cell : UITableViewCell

+(Section2Cell *)getSection2ViewWithTableView:(UITableView *)tableview;
@property (nonatomic,weak)NSArray * Section2ItemModelArray;
@property (nonatomic,copy)void(^section2ItemPushBlock)(Section2ItemModel *);
@property (nonatomic,copy)void(^authorButtonPushBlock)(NSString *,NSInteger);
@end
