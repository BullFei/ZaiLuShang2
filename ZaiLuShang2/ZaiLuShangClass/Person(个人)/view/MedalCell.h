//
//  MedalCell.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"
#import "LYAchievement.h"

@class MedalCell;

@protocol MedalCellDelegate <NSObject>

- (void)medalCell:(MedalCell *)cell iconTapped:(UITapGestureRecognizer *)tgr;
- (void)medalCell:(MedalCell *)cell medalTapped:(UITapGestureRecognizer *)tgr;

@end

@interface MedalCell : RootTableViewCell

// cell拥有一个frame模型
@property (nonatomic, strong) LYAchievement *achFrame;
/**************************************************************/

// 用户头像
@property (nonatomic, strong) UIImageView *icon;
// 作者
@property (nonatomic, strong) UILabel *author;
// 勋章图片
@property (nonatomic, strong) UIImageView *ig;
// 获得的勋章
@property (nonatomic, strong) UILabel *medal;
// 获得条件
@property (nonatomic, strong) UILabel *condition;
// 创建事件
@property (nonatomic, strong) UILabel *createAt;


@property (nonatomic) id<MedalCellDelegate>delegate;

/** 初始化方法,用frame模型初始化 */
- (instancetype)initWithLYAttention:(LYAchievement *)att;
@end
