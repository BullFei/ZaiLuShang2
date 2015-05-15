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
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:12];
    self.title.frame = self.attFrame.titleName;
    self.title.numberOfLines = 0;
    self.title.textColor = [UIColor blueColor];
    self.title.text = rec.tourtitle;
    [self.contentView addSubview:self.title];
    
    // 添加事件
    self.title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleAction:)];
    [self.title addGestureRecognizer:tapTitle];
    
    // 图片
    if (rec.picfile != nil) {
        self.ig = [[UIImageView alloc] initWithFrame:self.attFrame.ig];
        // 拼接URL
        self.ig.backgroundColor = [UIColor cyanColor];
        NSString *imageURL = [NSString stringWithFormat:@"%@%s%@",rec.picdomain, BIG_IMAGE, rec.picfile];
        [self.ig sd_setImageWithURL:[NSURL URLWithString:imageURL]];
        [self.contentView addSubview:self.ig];
        
        // 给图片添加事件
        self.ig.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapIg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(igAction:)];
        [self.ig addGestureRecognizer:tapIg];
    }
    
    // 正文内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.frame = self.attFrame.content;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = rec.words;
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.contentLabel];
    
    // 两个按钮
    self.likeButton = [[UIButton alloc] init];
    self.likeButton.frame = self.attFrame.likeCnt;
    self.likeButton.layer.cornerRadius = 5;
    self.likeButton.layer.masksToBounds = YES;
    self.likeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.likeButton.layer.borderWidth = 1;
    self.likeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 将图片处理为缩小版
    UIImage *likeImage = [UIImage imageNamed:@"icon_like_line_red_24"];
    NSData *likeData = UIImagePNGRepresentation(likeImage);
    likeImage = [UIImage imageWithData:likeData scale:2];
    
    if (rec.likeCnt.intValue == 0) {
        self.likeButton.imageView.contentMode = UIViewContentModeCenter;
    } else {
        [self.likeButton setTitle:rec.likeCnt forState:UIControlStateNormal];
    }
    [self.likeButton setImage:likeImage forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeButton];
    
    
    self.commentButton = [[UIButton alloc] init];
    self.commentButton.frame = self.attFrame.cmtCnt;
    self.commentButton.layer.cornerRadius = 5;
    self.commentButton.layer.masksToBounds = YES;
    self.commentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentButton.layer.borderWidth = 1;
    self.commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *cmtImage = [UIImage imageNamed:@"icon_comment_line_blue_24"];
    NSData *cmtData = UIImagePNGRepresentation(cmtImage);
    cmtImage = [UIImage imageWithData:cmtData scale:2];
    
    if (rec.cntcmt.integerValue == 0) {
        self.commentButton.imageView.contentMode = UIViewContentModeCenter;
    } else {
        [self.commentButton setTitle:rec.cntcmt forState:UIControlStateNormal];
    }
    [self.commentButton setImage:cmtImage forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.commentButton];
    
    
}

// 头像被点击的方法
- (void)iconAction:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(iconTapped:) withObject:tgr];
}
// 标题被点击的方法
- (void)titleAction:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(titleTapped:) withObject:tgr];
}
// 图片被点击的方法
- (void)igAction:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(igTapped:) withObject:tgr];
}
@end
