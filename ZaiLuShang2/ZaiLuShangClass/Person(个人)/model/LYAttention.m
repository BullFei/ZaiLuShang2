//
//  LYAttention.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYAttention.h"
#import "LYRec.h"
#import "LYOwner.h"
#import "TimeIntervalTool.h"
#import "LYComment.h"

#define LYZLS_ICON_WIDTH 102
#define LYZLS_BLANK_WIDTH 5
#define LYZLS_BUTTON_HEIGHT 20
#define LYZLS_BUTTON_WIDTH 56

@implementation LYAttention

- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)model {
    if (self = [super init]) {
        self.lyam = model;
        [self configFrame];
    }
    return self;
}
- (void)configFrame {
    // 一些预处理
    LYRec *rec = (LYRec *)self.lyam.item;
    
    // 头像的frame
    CGFloat iconX = LYZLS_BLANK_WIDTH;
    CGFloat iconY = LYZLS_BLANK_WIDTH * 2;
    CGFloat iconW = LYZLS_ICON_WIDTH / 2;
    CGFloat iconH = LYZLS_ICON_WIDTH / 2;
    self.icon = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 标题
    CGFloat authorX = CGRectGetMaxX(self.icon) + LYZLS_BLANK_WIDTH;
    CGFloat authorY = iconY;
    
    // 标题分为三部分, 作者,  干了什么, 标题
    NSString *authorString = rec.owner.nickname;
    CGSize authorSize = [authorString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TextFont_15, NSFontAttributeName, nil]];
    self.author = (CGRect){{authorX, authorY}, authorSize};
    
    NSString *eventString = @"更新了游记";
    CGFloat eventX = CGRectGetMaxX(self.author) + LYZLS_BLANK_WIDTH;
    CGFloat eventY = authorY;
    CGSize eventSize = [eventString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TextFont_15, NSFontAttributeName, nil]];
    self.event = (CGRect){{eventX, eventY}, eventSize};
    

    // 标题另起一行
    NSString *titleString = rec.tourtitle;
    CGFloat titleX = authorX;
    CGFloat titleY = CGRectGetMaxY(self.author) + LYZLS_BLANK_WIDTH;
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:TextFont_15 forKey:NSFontAttributeName] context:nil].size;
    self.titleName = (CGRect){{titleX, titleY}, titleSize};
    
    // 图片 先检测是否有图片
    if (rec.picfile.length != 0) {
        // 有图片 图片宽度是固定的 根据比例求出高度
        CGFloat igX = authorX;
        CGFloat igY = CGRectGetMaxY(self.titleName) + LYZLS_BLANK_WIDTH;
        CGFloat igW = SCREEN_WIDTH - self.icon.size.width - 4 * LYZLS_BLANK_WIDTH;
        
        //图片的比例
        double igScale = rec.pich.doubleValue / rec.picw.doubleValue;
        // 图片的高度
        CGFloat igH = igW * igScale;
        self.ig = CGRectMake(igX, igY, igW, igH);
    } else {
        // 没有图片,赋值为零
        self.ig = CGRectZero;
    }
    
    // 内容
    CGFloat contentX = authorX;
    // 标题的Y最大值,加上图片的高度,加上两个空白行的距离==内容的Y值
    CGFloat contentY = CGRectGetMaxY(self.titleName) + self.ig.size.height + 2 * LYZLS_BLANK_WIDTH;
    // 计算content的Size
    CGSize contentSize = [rec.words boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 4*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:TextFont_15 forKey:NSFontAttributeName] context:nil].size;
    self.content = (CGRect){{contentX, contentY}, contentSize};
    
    // 两个按钮
    
    // 喜欢按钮
    CGFloat likeX = authorX;
    CGFloat likeY = CGRectGetMaxY(self.content) + 2 * LYZLS_BLANK_WIDTH;
    CGFloat likeW = LYZLS_BUTTON_WIDTH;
    CGFloat likeH = LYZLS_BUTTON_HEIGHT;
    self.likeCnt = CGRectMake(likeX, likeY, likeW, likeH);
    
    // 评论按钮
    CGFloat cmtX = CGRectGetMaxX(self.likeCnt) + 2 * LYZLS_BLANK_WIDTH;
    CGFloat cmtY = likeY;
    CGFloat cmtW = likeW;
    CGFloat cmtH = likeH;
    self.cmtCnt = CGRectMake(cmtX, cmtY, cmtW, cmtH);
    
    // 创建于
    NSString *ct = [TimeIntervalTool timeIntervalFromTimeString:self.lyam.timestamp];
    CGSize ctSize = [ct sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TextFont_15, NSFontAttributeName, nil]];
    CGFloat ctX = SCREEN_WIDTH - 2*LYZLS_BLANK_WIDTH - ctSize.width;
    CGFloat ctY = cmtY;
    self.createAt = (CGRect){{ctX, ctY}, ctSize};
    
    // 是否有评论
    if (rec.comments.count == 0 || rec.comments == nil) {
        // 没有评论的话,cell的高度已经确定
        self.cellHeight = CGRectGetMaxY(self.createAt) + 2 * LYZLS_BLANK_WIDTH;
    } else {
        // 有评论的话,计算评论所占的高度,计算出cell的高度
        
        // 第一个评论
        self.commentatorIcon1 = CGRectMake(authorX, CGRectGetMaxY(self.likeCnt) + 4 * LYZLS_BLANK_WIDTH, LYZLS_ICON_WIDTH/4, LYZLS_ICON_WIDTH/4);
        // 评论的内容拼接
        LYComment *commentModel1 = rec.comments[0];
        NSString *cnt = [NSString stringWithFormat:@"%@:%@",commentModel1.user.nickname, commentModel1.words];
        // 计算size
        CGSize size1 = [cnt boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 4*LYZLS_BLANK_WIDTH - self.icon.size.width - self.icon.size.width/2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:TextFont_15 forKey:NSFontAttributeName] context:nil].size;
        self.commentContent1 = (CGRect){{CGRectGetMaxX(self.commentatorIcon1) + 2*LYZLS_BLANK_WIDTH, self.commentatorIcon1.origin.y}, size1 };
        
        // 如果运行到此处,cell的高度会改变
        self.cellHeight = CGRectGetMaxY(self.commentatorIcon1) + 2 * LYZLS_BLANK_WIDTH;
        
        // 第二个评论, 如果评论数量大于等于2的话
        if (rec.comments.count >= 2) {
            // 第二个评论内容拼接
            LYComment *commentModel2 = rec.comments[1];
            NSString *cnt1 = [NSString stringWithFormat:@"%@:%@",commentModel2.user.nickname, commentModel2.words];
            
            // 第二个评论的头像的frame
            self.commentatorIcon2 = CGRectMake(authorX, CGRectGetMaxY(self.commentatorIcon1) + 4 * LYZLS_BLANK_WIDTH, LYZLS_ICON_WIDTH/4, LYZLS_ICON_WIDTH/4);
            
            // 计算Size
            CGSize size2 = [cnt1 boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 4*LYZLS_BLANK_WIDTH - self.icon.size.width - self.icon.size.width/2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:TextFont_15 forKey:NSFontAttributeName] context:nil].size;
            
            self.commmentContent2 = (CGRect){{CGRectGetMaxX(self.commentatorIcon2) + 2*LYZLS_BLANK_WIDTH, self.commentatorIcon2.origin.y}, size2 };
            
            // 第一条评论的内容越过了头像的话, 第二个评论的Y值就要以内容为准
            if (CGRectGetMaxY(self.commentContent1) > CGRectGetMaxY(self.commentatorIcon1)) {
                // 第二个评论的头像的frame
                self.commentatorIcon2 = CGRectMake(authorX, CGRectGetMaxY(self.commentContent1) + 4 * LYZLS_BLANK_WIDTH, LYZLS_ICON_WIDTH/4, LYZLS_ICON_WIDTH/4);
                self.commmentContent2 = (CGRect){{CGRectGetMaxX(self.commentatorIcon1) + 2*LYZLS_BLANK_WIDTH, self.commentatorIcon2.origin.y}, size2 };
            }
            
            
            // 根据内容的大小计算以头像还是内容为标准
            if (CGRectGetMaxY(self.commmentContent2) > CGRectGetMaxY(self.commentatorIcon2)) {
                self.cellHeight = CGRectGetMaxY(self.commmentContent2) + 2 * LYZLS_BLANK_WIDTH;
            } else {
                self.cellHeight = CGRectGetMaxY(self.commentatorIcon2) + 2 * LYZLS_BLANK_WIDTH;
            }
            
            // 评论的数量不止2条的话,追加一个"阅读更多评论"的Size.height
            if (rec.cntcmt.integerValue != 2) {
                if (CGRectGetMaxY(self.commmentContent2) > CGRectGetMaxY(self.commentatorIcon2)) {
                    // 第二条评论的内容的最大Y值如果大于头像的Y值,以评论内容为准
                    self.cellHeight = CGRectGetMaxY(self.commmentContent2) + 20 + 4 * LYZLS_BLANK_WIDTH;
                } else {
                    self.cellHeight = CGRectGetMaxY(self.commentatorIcon2) + 20 + 4 * LYZLS_BLANK_WIDTH;
                }
            }
        }
    }
}
@end
