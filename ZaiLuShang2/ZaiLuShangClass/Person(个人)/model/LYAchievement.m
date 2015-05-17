//
//  LYAchievement.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYAchievement.h"
#import "LYAchv.h"
#import "LYOwner.h"
#import "TimeIntervalTool.h"

#define LYZLS_ICON_WIDTH 102
#define LYZLS_BLANK_WIDTH 5
#define LYZLS_TEXTSIZE 13
#define LYZLS_MEDAL_WIDTH 88

@implementation LYAchievement
- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)model {
    if (self = [super init]) {
        self.lyam = model;
        [self configFrame];
    }
    return self;
}

- (void)configFrame {
    // 预处理
    LYAchv *ach = (LYAchv *)self.lyam.item;
    LYOwner *owner = ach.user;
    
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
    
    // 获得勋章
    NSString *eventString = @"获得勋章";
    CGFloat eventX = CGRectGetMaxX(self.author) + LYZLS_BLANK_WIDTH;
    CGFloat eventY = authorY;
    CGSize eventSize = [eventString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LYZLS_TEXTSIZE], NSFontAttributeName, nil]];
    self.event = (CGRect){{eventX, eventY}, eventSize};
    
    // 勋章图案
    CGFloat igX = authorX;
    CGFloat igY = CGRectGetMaxY(self.author) + LYZLS_BLANK_WIDTH;
    self.ig = CGRectMake(igX, igY, LYZLS_MEDAL_WIDTH, LYZLS_MEDAL_WIDTH);
    
    // 勋章头衔
    CGFloat medalX = CGRectGetMaxX(self.ig) + LYZLS_BLANK_WIDTH;
    CGFloat medalY = igY;
    NSString *medalString = ach.title;
        CGSize medalSize = [medalString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LYZLS_TEXTSIZE], NSFontAttributeName, nil]];
        self.medal = (CGRect){{medalX, medalY}, medalSize};
    
    
    
    // 获得勋章条件
    CGFloat conditionX = medalX;
    CGFloat conditionY = CGRectGetMaxY(self.medal) + LYZLS_BLANK_WIDTH;
    NSString *con = @"获得条件:";
    NSString *conditionString = ach.desc;
    if (conditionString != nil) {
        con = [con stringByAppendingString:conditionString];
    }
    // 获得条件有可能会占据多行空间
    CGSize conditionSize = [con boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 4*LYZLS_BLANK_WIDTH - self.icon.size.width - self.ig.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:LYZLS_TEXTSIZE] forKey:NSFontAttributeName] context:nil].size;
    self.condition = (CGRect){{conditionX, conditionY}, conditionSize};
    
    //  创建时间
    NSString *tttt = [TimeIntervalTool timeIntervalFromTimeString:self.lyam.timestamp];
    CGSize createAtSize = [tttt sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LYZLS_TEXTSIZE], NSFontAttributeName, nil]];
    CGFloat createAtX = SCREEN_WIDTH - 2*LYZLS_BLANK_WIDTH - createAtSize.width;
    CGFloat createAtY = CGRectGetMaxY(self.condition) + 3 * LYZLS_BLANK_WIDTH;
    self.createAt = (CGRect){{createAtX, createAtY}, createAtSize};
    
    self.cellHeight = CGRectGetMaxY(self.ig) + 2 * LYZLS_BLANK_WIDTH;
    
}
@end
