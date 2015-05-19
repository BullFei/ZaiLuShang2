//
//  MedalCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MedalCell.h"
#import "LYAchv.h"
#import "UIImageView+WebCache.h"
#import "TimeIntervalTool.h"


@implementation MedalCell

- (instancetype)initWithLYAttention:(LYAchievement *)att {
    if (self = [super init]) {
        self.achFrame = att;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    LYAchv *ach = (LYAchv *)self.achFrame.lyam.item;
    LYOwner *owner = ach.user;
    
    // 头像
    self.icon = [[UIImageView alloc] init];
    self.icon.frame = self.achFrame.icon;
    self.icon.backgroundColor = [UIColor greenColor];
    self.icon.layer.cornerRadius = 102/4;
    self.icon.layer.masksToBounds = YES;
    NSString *url = [NSString stringWithFormat:@"%@%@%@", owner.picdomain, SMALL_HEAD, owner.avatar];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    [self.contentView addSubview:self.icon];
    
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped:)];
    [self.icon addGestureRecognizer:tgrIcon];
    
    // 作者
    self.author = [[UILabel alloc] init];
    self.author.frame = self.achFrame.author;
    self.author.textColor = [UIColor blueColor];
    self.author.font = TextFont_15;
    self.author.text = owner.nickname;
    self.author.userInteractionEnabled = YES;
    [self.contentView addSubview:self.author];
    
    self.author.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrAuthor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped:)];
    [self.author addGestureRecognizer:tgrAuthor];
    
    // 事件
    NSString *eve = @"获得勋章";
    UILabel *eveLabel = [[UILabel alloc] init];
    eveLabel.frame = self.achFrame.event;
    eveLabel.textColor = [UIColor blackColor];
    eveLabel.font = TextFont_15;
    eveLabel.text = eve;
    [self.contentView addSubview:eveLabel];
    
    // 勋章图
    self.ig = [[UIImageView alloc] init];
    self.ig.frame = self.achFrame.ig;
    [self.ig sd_setImageWithURL:[NSURL URLWithString:ach.pic_mini] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    [self.contentView addSubview:self.ig];
    self.ig.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrIg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(medalTapped:)];
    [self.ig addGestureRecognizer:tgrIg];
    
    // 勋章头衔
    self.medal = [[UILabel alloc] init];
    self.medal.frame = self.achFrame.medal;
    self.medal.textColor = [UIColor blackColor];
    self.medal.font = TextFont_15;
    self.medal.text = ach.title;
    [self.contentView addSubview:self.medal];

    // 获得条件
    NSString *con = @"获得条件:";
    NSString *de = ach.desc;
    if (de != nil) {
        con = [con stringByAppendingString:de];
    }
    self.condition = [[UILabel alloc] init];
    self.condition.frame = self.achFrame.condition;
    self.condition.font = TextFont_15;
    self.condition.text = con;
    self.condition.numberOfLines = 0;
    self.condition.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.condition];
    
    // 创建时间
    self.createAt = [[UILabel alloc] init];
    self.createAt.frame = self.achFrame.createAt;
    self.createAt.font = TextFont_15;
    self.createAt.textColor = [UIColor lightGrayColor];
    self.createAt.text = [TimeIntervalTool timeIntervalFromTimeString:self.achFrame.lyam.timestamp];
    [self.contentView addSubview:self.createAt];
}

// 头像和作者
- (void)iconTapped:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(medalCell:iconTapped:) withObject:self withObject:tgr];
}
- (void)medalTapped:(UITapGestureRecognizer *)tgr {
    CXLog(@">>>>>>>>>>>>>>>");
    [self.delegate performSelector:@selector(medalCell:medalTapped:) withObject:self withObject:tgr];
}
@end
