//
//  CommentContentCell.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"
#import "LYCommentFrameModel.h"

@interface CommentContentCell : RootTableViewCell
@property (nonatomic, strong) LYCommentFrameModel *commentModel;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *words;

- (instancetype)initWithCommentFrameModel:(LYCommentFrameModel *)cfm;
- (void)configUI;

@end
