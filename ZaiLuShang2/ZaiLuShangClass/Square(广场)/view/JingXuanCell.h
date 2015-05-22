//
//  JingXuanCell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingXuanModel.h"
#import "CommentModel.h"
@interface JingXuanCell : UITableViewCell
+(JingXuanCell *)GetJingXuanCellWithTableView:(UITableView *)tableview;
@property (nonatomic,weak)JingXuanModel * jingXuanModel;
@property (nonatomic,weak)NSArray * CommentModelArray;
@property (nonatomic,copy)void(^authorButtonPushBlock)(NSString *, NSInteger webPageType );
-(void)refreshCommentsScrollView;
@end
