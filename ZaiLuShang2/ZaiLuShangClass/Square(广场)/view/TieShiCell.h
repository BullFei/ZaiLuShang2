//
//  TieShiCell.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCAttentionModel.h"
#import "TieShiModel.h"
@interface TieShiCell : UITableViewCell
@property (nonatomic,strong)UIButton * authorButton;
@property (nonatomic,strong)UILabel * nicknameLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIView * tagsView;
@property (nonatomic,strong)UILabel * wordsLabel;
@property (nonatomic,strong)UIImageView * oneImageView;
@property (nonatomic,strong)UIView * picsView;
@property (nonatomic,strong)UIButton * zanButton;
@property (nonatomic,strong)UIButton * commentButton;
@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,weak)TieShiModel * tsm;
@property (nonatomic,weak)NSArray  * tagsModelArray;
@property (nonatomic,weak)NSArray * pictureModelArray;
+(TieShiCell *)getTieShiCellWithTableView:(UITableView *)tableView attetionModel:(ZYCAttentionModel *)attM;
+(TieShiCell *)getTieShiCellWithZYCAttention:(ZYCAttentionModel *)attM;
@end
