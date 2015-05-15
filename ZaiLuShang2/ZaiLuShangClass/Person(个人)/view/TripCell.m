//
//  TripCell.m
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TripCell.h"
#import "UIImageView+WebCache.h"
#import "LYRec.h"
#import "LYOwner.h"


@implementation TripCell
- (instancetype)initWithLYAttention:(LYAttention *)attention {
    if (self = [super init]) {
        self.attFrame = attention;
        
        [self configUI];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)configUI {
    // 准备工作
    LYRec *rec = (LYRec *)self.attFrame.lyam.item;
    
    // 头像
    self.icon = [[UIImageView alloc] init];
    self.icon.frame = self.attFrame.icon;
    // 拼接头像的URL地址
    NSString *url = [NSString stringWithFormat:@"%@%s%@", rec.owner.picdomain, SMALL_HEAD, rec.owner.avatar];
    // 头像切圆角
    self.icon.layer.cornerRadius = 102/4;
    self.icon.layer.masksToBounds = YES;
    // 从网络上加载头像
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];
    // 添加到cell中
    [self.contentView addSubview:self.icon];
    
    // 添加事件
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconAction:)];
    self.icon.userInteractionEnabled = YES;
    [self.icon addGestureRecognizer:tgr];
    
    
    /*==================================================================================*/
    // 标题
    self.author = [[UILabel alloc] init];
    self.author.frame = self.attFrame.author;
    self.author.textColor = [UIColor blueColor];
    self.author.font = [UIFont systemFontOfSize:12];
    self.author.text = rec.owner.nickname;
    self.author.userInteractionEnabled = YES;
    [self.contentView addSubview:self.author];
    
    // 添加事件
    UITapGestureRecognizer *tgrName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconAction:)];
    [self.author addGestureRecognizer:tgrName];
    
    
    NSString *eve = @"更新了游记";
    UILabel *eveLabel = [[UILabel alloc] init];
    eveLabel.frame = self.attFrame.event;
    eveLabel.textColor = [UIColor blackColor];
    eveLabel.font = [UIFont systemFontOfSize:12];
    eveLabel.text = eve;
    [self.contentView addSubview:eveLabel];
    
    int len1 = self.author.text.length;
    int len2 = eve.length;
    NSMutableString *nsms = [[NSMutableString alloc] init];
    for (int i = 0; i < len1 + len2 + 1; i++) {// 这里+2意思指空白多出来的地方,
        [nsms insertString:@"　" atIndex:0];
    }
    if (rec.tourtitle != nil) {
        [nsms insertString:rec.tourtitle atIndex:nsms.length];
    }
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:12];
    self.title.frame = self.attFrame.titleName;
    self.title.numberOfLines = 0;
    self.title.textColor = [UIColor blueColor];
    self.title.text = nsms;
    
    [self.contentView addSubview:self.title];
    
    
    
}

// 头像被点击的方法
- (void)iconAction:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(iconTapped:) withObject:tgr];
}
@end
