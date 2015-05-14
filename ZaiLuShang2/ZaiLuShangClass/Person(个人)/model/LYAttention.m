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
    
    // 获取authorString的长度
    int len = authorString.length;
    int len1 = eventString.length;
    
    NSString *titleString = rec.tourtitle;
    NSMutableString *titleString1 = [[NSMutableString alloc] init];
    for (int i = 0; i < len + len1; i++) {
        [titleString1 insertString:@"　" atIndex:0];
    }
    if (titleString != nil) {
        [titleString1 insertString:titleString atIndex:titleString1.length];
    }
    
    NSLog(@"%@", titleString1);
    CGFloat titleX = authorX;
    CGFloat titleY = authorY;
    CGSize titleSize = [titleString1 boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 3*LYZLS_BLANK_WIDTH - self.icon.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil].size;
    NSLog(@"%@", NSStringFromCGRect(self.icon));
    self.titleName = (CGRect){{titleX, titleY}, titleSize};
// 这个label的内容
}
@end
