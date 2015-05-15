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
    CGSize authorSize = [authorString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil]];
    self.author = (CGRect){{authorX, authorY}, authorSize};
    
    NSString *eventString = @"更新了游记";
    CGFloat eventX = CGRectGetMaxX(self.author) + LYZLS_BLANK_WIDTH;
    CGFloat eventY = authorY;
    CGSize eventSize = [eventString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil]];
    self.event = (CGRect){{eventX, eventY}, eventSize};
    

    // 标题另起一行
    NSString *titleString = rec.tourtitle;
    CGFloat titleX = authorX;
    CGFloat titleY = CGRectGetMaxY(self.author) + LYZLS_BLANK_WIDTH;
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil].size;
    self.titleName = (CGRect){{titleX, titleY}, titleSize};
    
    // 图片 先检测是否有图片
    if (rec.picfile != nil) {
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
    CGSize contentSize = [rec.words boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 4*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil].size;
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
    
  
    
}
@end
