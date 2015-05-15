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
#import "TimeIntervalTool.h"
#import "LYComment.h"

#define LYZLS_TEXTSIZE 12

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
    NSString *url = [NSString stringWithFormat:@"%@%@%@", rec.owner.picdomain, SMALL_HEAD, rec.owner.avatar];
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
    self.author.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
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
    eveLabel.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
    eveLabel.text = eve;
    [self.contentView addSubview:eveLabel];
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
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
        NSString *imageURL = [NSString stringWithFormat:@"%@%@%@",rec.picdomain, BIG_IMAGE, rec.picfile];
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
    self.contentLabel.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
    [self.contentView addSubview:self.contentLabel];
    
    // 两个按钮
    self.likeButton = [[LYLCButton alloc] init];
    self.likeButton.frame = self.attFrame.likeCnt;
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
    
    
    self.commentButton = [[LYLCButton alloc] init];
    self.commentButton.frame = self.attFrame.cmtCnt;
    
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
    
    // 创建时间
    if (self.attFrame.lyam.timestamp != nil) {
        NSString *t = [TimeIntervalTool timeIntervalFromTimeString:self.attFrame.lyam.timestamp];
        
        self.createAtLabel = [[UILabel alloc] init];
        self.createAtLabel.frame = self.attFrame.createAt;
        self.createAtLabel.text = t;
        self.createAtLabel.textColor = [UIColor lightGrayColor];
        self.createAtLabel.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
        [self.contentView addSubview:self.createAtLabel];
    }
    
    // 评论,如果有的话,
    if (rec.comments != nil) {
        // 添加分割线
//        UILabel *sep1 = [[UILabel alloc] initWithFrame:CGRectMake(self.ig.frame.origin.x, CGRectGetMaxY(self.likeButton.frame) + 2 * 5, SCREEN_HEIGHT - self.icon.frame.size.width - 2*5, 1)];
//        sep1.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:sep1];
        
        // 头像
        LYComment *cmt1 = rec.comments[0];
        self.commentatorIcon1 = [[UIImageView alloc] init];
        self.commentatorIcon1.frame = self.attFrame.commentatorIcon1;
        self.commentatorIcon1.layer.cornerRadius = self.attFrame.commentatorIcon1.size.width/2;
        self.commentatorIcon1.layer.masksToBounds = YES;
        NSString *url = [NSString stringWithFormat:@"%@%@%@", cmt1.user.picdomain,SMALL_HEAD, cmt1.user.avatar];
        [self.commentatorIcon1 sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.contentView addSubview:self.commentatorIcon1];
        
        // 文字
        NSString *cnt = [NSString stringWithFormat:@"%@:%@",cmt1.user.nickname, cmt1.words];
        self.commentContent1 = [[UILabel alloc] init];
        self.commentContent1.frame = self.attFrame.commentContent1;
        self.commentContent1.text = cnt;
        self.commentContent1.font = [UIFont systemFontOfSize:LYZLS_TEXTSIZE];
        [self.contentView addSubview:self.commentContent1];
        
        
    }
    
    
    
    
    
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
