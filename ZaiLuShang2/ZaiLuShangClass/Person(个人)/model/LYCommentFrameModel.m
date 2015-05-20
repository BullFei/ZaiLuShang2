//
//  LYCommentFrameModel.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYCommentFrameModel.h"

#define LYZLS_ICON_WIDTH 40
#define IMAGEVIEW_BORDER 5

@implementation LYCommentFrameModel

- (instancetype )initWithCommentModel:(LYComment *)comment {
    if (self = [super init]) {
        self.cmt = comment;
        [self configFrame];
    }
    return self;
}

- (void)configFrame {
    LYOwner *owner = self.cmt.user;
    // 头像iconView
    CGFloat iconViewW = LYZLS_ICON_WIDTH;
    CGFloat iconViewH = LYZLS_ICON_WIDTH;
    CGFloat iconViewX = IMAGEVIEW_BORDER;
    CGFloat iconViewY = 5;
    self.icon = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // nameLabel
    CGSize nameLabelSize = [owner.nickname sizeWithAttributes:@{NSFontAttributeName : TextFont_15}];
    CGFloat nameLabelX = CGRectGetMaxX(self.icon)+IMAGEVIEW_BORDER;
    CGFloat nameLabelY = iconViewY;
    self.title = (CGRect){nameLabelX, nameLabelY, nameLabelSize};
    
    // 时间
    CGSize timeLabelSize = [self.cmt.timestamp sizeWithAttributes:@{NSFontAttributeName : TextFont_15}];
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(self.icon)-timeLabelSize.height;
    self.time = (CGRect){timeLabelX, timeLabelY, timeLabelSize};
    
    // 正文
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - CGRectGetMidX(self.icon)-IMAGEVIEW_BORDER, CGFLOAT_MAX);
    CGRect contentLabelRect = [self.cmt.words boundingRectWithSize:textMaxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : TextFont_15} context:nil];
    CGFloat contentLabelX = CGRectGetMidX(self.icon);
    CGFloat contentLabelY = CGRectGetMaxY(self.icon)+10;
    self.words = (CGRect){contentLabelX, contentLabelY, textMaxSize.width, contentLabelRect.size.height};
    
    self.cellHeight = CGRectGetMaxY(self.words) + 10;
}

@end
