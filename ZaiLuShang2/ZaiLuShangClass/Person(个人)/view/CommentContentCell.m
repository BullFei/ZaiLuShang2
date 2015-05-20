//
//  CommentContentCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentContentCell.h"
#import "UIImageView+WebCache.h"

#define LYZLS_ICON_WIDTH 40

@implementation CommentContentCell

- (instancetype)initWithCommentFrameModel:(LYCommentFrameModel *)cfm {
    if (self = [super init]) {
        self.commentModel = cfm;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    LYComment *cmt = self.commentModel.cmt;
    
    self.icon = [[UIImageView alloc] init];
    self.icon.frame = self.commentModel.icon;
    self.icon.layer.cornerRadius = LYZLS_ICON_WIDTH/2;
    self.icon.layer.masksToBounds = YES;
    NSString *url = [NSString stringWithFormat:@"%@%@%@", cmt.user.picdomain, SMALL_HEAD, cmt.user.avatar];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    [self.contentView addSubview:self.icon];
    
    
    self.name = [[UILabel alloc] init];
    self.name.frame = self.commentModel.title;
    self.name.text = self.commentModel.cmt.user.nickname;
    self.name.font = TextFont_15;
    self.name.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.name];
    
    self.words = [[UILabel alloc] init];
    self.words.frame = self.commentModel.words;
    self.words.font = TextFont_15;
    self.words.textColor = [UIColor blackColor];
    self.words.numberOfLines = 0;
    self.words.text = self.commentModel.cmt.words;
    [self.contentView addSubview:self.words];
    
    self.time = [[UILabel alloc] init];
    self.time.frame = self.commentModel.time;
    self.time.text = self.commentModel.cmt.timestamp;
    self.time.font = TextFont_15;
    self.time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.time];
    
    //cell分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, self.commentModel.cellHeight - 1, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}
@end
