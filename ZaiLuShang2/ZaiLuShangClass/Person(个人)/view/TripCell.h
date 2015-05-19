//
//  TripCell.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"
#import "STTweetLabel.h"
#import "LYAttention.h"
#import "LYLCButton.h"

@class TripCell;

@protocol TripCellDelegate <NSObject>

- (void)tripCell:(TripCell *)cell iconTapped:(UITapGestureRecognizer *)tgr;
- (void)tripCell:(TripCell *)cell titleTapped:(UITapGestureRecognizer *)tgr;
- (void)tripCell:(TripCell *)cell imageTapped:(UITapGestureRecognizer *)tgr;
- (void)readMoreButtonClicked:(TripCell *)cell;
- (void)contentTapped:(UITapGestureRecognizer *)tgr;

@end

@interface TripCell : RootTableViewCell

// 回传事件的代理
@property (nonatomic) id<TripCellDelegate> delegate;

/**
 *  cell拥有一个frame
 */
@property (nonatomic, strong) LYAttention *attFrame;
/*******************************************************/
// 头像
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UILabel *title;
// 标题
// 图片
@property (nonatomic, strong) UIImageView *ig;
// 正文内容
@property (nonatomic, strong) UILabel *contentLabel;
// 喜欢按钮
@property (nonatomic, strong) LYLCButton *likeButton;
// 评论按钮
@property (nonatomic, strong) LYLCButton *commentButton;
// 创建时间
@property (nonatomic, strong) UILabel *createAtLabel;

/*******************************************************/
// 展示两条评论
@property (nonatomic, strong) UIImageView *commentatorIcon1;
@property (nonatomic, strong) UIImageView *commentatorIcon2;

@property (nonatomic, strong) UILabel *commentContent1;
@property (nonatomic, strong) UILabel *commentContent2;


- (instancetype)initWithLYAttention:(LYAttention *)attention;
@end
