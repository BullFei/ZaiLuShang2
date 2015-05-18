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
    self.author.font = TextFont_15;
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
    eveLabel.font = TextFont_15;
    eveLabel.text = eve;
    [self.contentView addSubview:eveLabel];
    
    self.title = [[UILabel alloc] init];
    self.title.font = TextFont_15;
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
    if (rec.picfile.length != 0) {
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
    
    // 判断正文内容有无超级链接网址
    NSString *act = rec.words;
    if (act != nil) {
        NSRange range = [act rangeOfString:@"http"];
        if (range.location != NSNotFound) { // 正文中有超级链接
            NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:act];
            [mas addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(range.location, act.length - range.location)];
            [mas addAttribute:NSFontAttributeName value:TextFont_15 range:NSMakeRange(0, act.length)];
            self.contentLabel.attributedText = mas;
            
            //添加手势
            self.contentLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(websiteAction:)];
            [self.contentLabel addGestureRecognizer:tgr];
        } else {
            // 正文中没有超级链接
            self.contentLabel.text = act;
            self.contentLabel.font = TextFont_15;
        }
    }
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
        self.createAtLabel.font = TextFont_15;
        [self.contentView addSubview:self.createAtLabel];
    }
    
    // 评论,如果有的话,
    if (rec.comments.count != 0) {
//         添加分割线
        UILabel *sep1 = [[UILabel alloc] initWithFrame:CGRectMake(self.author.frame.origin.x, CGRectGetMaxY(self.likeButton.frame) + 2 * 5, SCREEN_HEIGHT - self.icon.frame.size.width - 2*5, 0.5)];
        sep1.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:sep1];
        
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
        self.commentContent1.numberOfLines = 0;
        self.commentContent1.font = TextFont_15;
        [self.contentView addSubview:self.commentContent1];
        
        // 第二个评论,如果有的话
        if (rec.comments.count >= 2) {
            // 添加一条分割线
//            UILabel *sep2 = [[UILabel alloc] initWithFrame:CGRectMake(self.author.frame.origin.x, CGRectGetMaxY(self.commentatorIcon1.frame) + 2 * 5, SCREEN_HEIGHT - self.icon.frame.size.width - 2*5, 0.5)];
//            sep2.backgroundColor = [UIColor lightGrayColor];
//            [self.contentView addSubview:sep2];
            
            // 第二个评论的头像
            LYComment *cmt2 = rec.comments[1];
            self.commentatorIcon2 = [[UIImageView alloc] init];
            self.commentatorIcon2.frame = self.attFrame.commentatorIcon2;
            self.commentatorIcon2.layer.cornerRadius = self.attFrame.commentatorIcon1.size.width/2;
            self.commentatorIcon2.layer.masksToBounds = YES;
            
            NSString *url = [NSString stringWithFormat:@"%@%@%@", cmt2.user.picdomain,SMALL_HEAD, cmt2.user.avatar];
            [self.commentatorIcon2 sd_setImageWithURL:[NSURL URLWithString:url]];
            [self.contentView addSubview:self.commentatorIcon2];
            
            // 第二个评论的内容
            NSString *cnt2 = [NSString stringWithFormat:@"%@:%@",cmt2.user.nickname, cmt2.words];
            self.commentContent2 = [[UILabel alloc] init];
            self.commentContent2.frame = self.attFrame.commmentContent2;
            self.commentContent2.text = cnt2;
            self.commentContent2.numberOfLines = 0;
            self.commentContent2.font = TextFont_15;
            [self.contentView addSubview:self.commentContent2];
            
            //如果评论大于2条的话 添加一个"阅读全部(多少条)评论"的button
            if (rec.cntcmt.integerValue != 2) {
                UIButton *buttonMore = [[UIButton alloc] init];
                // 判断这个按钮的相对谁的位置(评论文字过长的话就以评论为准,比较短的话就以头像为准)
                if (CGRectGetMaxY(self.commentContent2.frame) > CGRectGetMaxY(self.commentatorIcon2.frame)) {
                    buttonMore.frame = CGRectMake(self.author.frame.origin.x, CGRectGetMaxY(self.commentContent2.frame) + 2 * 5, 150, 20);
                } else {
                    buttonMore.frame = CGRectMake(self.author.frame.origin.x, CGRectGetMaxY(self.commentatorIcon2.frame) + 2 * 5, 150, 20);
                }
                UIImage *more = [UIImage imageNamed:@"icon_more_gray_32"];
                NSData *moreData = UIImagePNGRepresentation(more);
                more = [UIImage imageWithData:moreData scale:2];
                [buttonMore setImage:more forState:UIControlStateNormal];
                [buttonMore setTitle:[NSString stringWithFormat:@"阅读全部%@条评论", rec.cntcmt] forState:UIControlStateNormal];
                [buttonMore setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                buttonMore.titleLabel.font = TextFont_15;
                [buttonMore addTarget:self action:@selector(readMoreComments:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:buttonMore];
            }
        }
    }
}
#pragma mark - 事件的方法
// 阅读更多评论
- (void)readMoreComments:(UIButton *)btn {
    NSLog(@"阅读更多评论");
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
// 正文内容如果含有链接的话的方法
- (void)websiteAction:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(contentTapped:) withObject:tgr];
}
@end
