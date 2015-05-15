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

@protocol TripCellDelegate <NSObject>

- (void)iconTapped:(UITapGestureRecognizer *)tgr;
- (void)titleTapped:(UITapGestureRecognizer *)tgr;
- (void)igTapped:(UITapGestureRecognizer *)tgr;

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
@property (nonatomic, strong) UIButton *likeButton;
// 评论按钮
@property (nonatomic, strong) UIButton *commentButton;
// 创建事件
@property (nonatomic, strong) UILabel *createAtLabel;


- (instancetype)initWithLYAttention:(LYAttention *)attention;
@end
