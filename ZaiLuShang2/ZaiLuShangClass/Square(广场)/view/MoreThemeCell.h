//
//  MoreThemeCell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreThemeCell : UITableViewCell
+(MoreThemeCell *)getMoreThemeCellWithTableView:(UITableView *)tableview;
@property (nonatomic,weak)NSArray * moreThemeModelArray;
@property (nonatomic,copy)void (^MoreThemeItemPushBlock)(NSString *);
@end
