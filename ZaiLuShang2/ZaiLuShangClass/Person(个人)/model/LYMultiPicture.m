//
//  LYMultiPicture.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYMultiPicture.h"

#define LYZLS_ICON_WIDTH 102
#define LYZLS_BLANK_WIDTH 5
#define LYZLS_TEXTSIZE 13
#define LYZLS_IMAGE_WIDTH ((SCREEN_WIDTH - 4 * LYZLS_BLANK_WIDTH - (LYZLS_ICON_WIDTH/2))/3)

@implementation LYMultiPicture

- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)im {
    if (self = [super init]) {
        self.informationModel = im;
        [self configFrame];
    }
    return self;
}

- (void)configFrame {
    
    LYItem *iiii = (LYItem *)self.informationModel.item;
    LYOwner *owner = iiii.user;
    LYTour *tour = iiii.tour;
    
    // 头像的frame
    CGFloat iconX = LYZLS_BLANK_WIDTH;
    CGFloat iconY = LYZLS_BLANK_WIDTH * 2;
    CGFloat iconW = LYZLS_ICON_WIDTH / 2;
    CGFloat iconH = LYZLS_ICON_WIDTH / 2;
    self.icon = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 作者
    CGFloat authorX = CGRectGetMaxX(self.icon) + LYZLS_BLANK_WIDTH;
    CGFloat authorY = iconY;
    // 作者名字
    NSString *nickname = owner.nickname;
    CGSize authorSize = [nickname sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LYZLS_TEXTSIZE], NSFontAttributeName, nil]];
    self.author = (CGRect){{authorX, authorY}, authorSize};
    
    // 动作
    NSString *eventString = [NSString stringWithFormat:@"上传了%@个记录到游记", iiii.piccnt];
    CGFloat eventX = CGRectGetMaxX(self.author) + LYZLS_BLANK_WIDTH;
    CGFloat eventY = authorY;
    CGSize eventSize = [eventString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LYZLS_TEXTSIZE], NSFontAttributeName, nil]];
    self.event = (CGRect){{eventX, eventY}, eventSize};
    
    // 标题另起一行
    NSString *titleString = tour.title;
    CGFloat titleX = authorX;
    CGFloat titleY = CGRectGetMaxY(self.author) + LYZLS_BLANK_WIDTH;
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:LYZLS_TEXTSIZE] forKey:NSFontAttributeName] context:nil].size;
    self.title = (CGRect){{titleX, titleY}, titleSize};
    
    // 图片预览
    CGFloat pictureX = authorX;
    CGFloat pictureY = CGRectGetMaxY(self.title) + 2 * LYZLS_BLANK_WIDTH;
    CGFloat pictureW = SCREEN_WIDTH - LYZLS_ICON_WIDTH/2 - 4 * LYZLS_BLANK_WIDTH;
    // 计算出图片的行数
    NSInteger pictureLineCount = (iiii.piccnt.integerValue + 2)/3;
    CGFloat pictureH = pictureLineCount * (LYZLS_BLANK_WIDTH + LYZLS_IMAGE_WIDTH);
    self.photoView = CGRectMake(pictureX, pictureY, pictureW, pictureH);
    
}

@end
