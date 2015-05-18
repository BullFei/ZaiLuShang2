//
//  MultiPictureCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MultiPictureCell.h"
#import "UIImageView+WebCache.h"
#import "LYTour.h"
#import "TimeIntervalTool.h"
#import "LYWebViewController.h"


@implementation MultiPictureCell

- (instancetype)initWithLYMultiPicture:(LYMultiPicture *)mp {
    if (self = [super init]) {
        self.mp = mp;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    LYAttentionModel *attm = (LYAttentionModel *)self.mp.informationModel;
    LYItem *iiii = (LYItem *)attm.item;
    LYOwner *owner = iiii.user;
    LYTour *tour = iiii.tour;
    
    // 头像
    self.icon = [[UIImageView alloc] init];
    self.icon.frame = self.mp.icon;
    self.icon.backgroundColor = [UIColor greenColor];
    self.icon.layer.cornerRadius = 102/4;
    self.icon.layer.masksToBounds = YES;
    NSString *url = [NSString stringWithFormat:@"%@%@%@", owner.picdomain, SMALL_HEAD, owner.avatar];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    [self.contentView addSubview:self.icon];
    // 给头像添加手势
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped:)];
    [self.icon addGestureRecognizer:tgrIcon];
    
    
    // 作者
    self.author = [[UILabel alloc] init];
    self.author.frame = self.mp.author;
    self.author.textColor = [UIColor blueColor];
    self.author.font = TextFont_15;
    self.author.text = owner.nickname;
    [self.contentView addSubview:self.author];
    // 给作者添加手势
    self.author.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrAuthor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped:)];
    [self.author addGestureRecognizer:tgrAuthor];
    
    // 动作
    NSString *eventString = [NSString stringWithFormat:@"上传了%@个记录到游记", iiii.piccnt];
    UILabel *eveLabel = [[UILabel alloc] init];
    eveLabel.frame = self.mp.event;
    eveLabel.textColor = [UIColor blackColor];
    eveLabel.font = TextFont_15;
    eveLabel.text = eventString;
    [self.contentView addSubview:eveLabel];
    
    // 标题
    self.title = [[UILabel alloc] init];
    self.title.font = TextFont_15;
    self.title.frame = self.mp.title;
    self.title.numberOfLines = 0;
    self.title.textColor = [UIColor blueColor];
    self.title.text = tour.title;
    [self.contentView addSubview:self.title];
    // 给标题添加手势
    self.title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgrTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTappedByController:)];
    [self.title addGestureRecognizer:tgrTitle];
    
    
    
    // 九宫格图片
    self.photo = [[LYPhotoView alloc] init];
    self.photo.frame = self.mp.photoView;
    // 设置代理
    self.photo.delegate = self;
    self.photo.imageCount = iiii.piccnt.integerValue;
    
    // 拼接URL地址
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    for (LYRec *rec in tour.records) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@", rec.picdomain, SMALL_IMAGE, rec.picfile];
        [urlArray addObject:url];
    }
    self.photo.imageURLS = urlArray;
    [self.photo configImages];
    [self.contentView addSubview:self.photo];
    
    // 创建时间
     NSString *time = [TimeIntervalTool timeIntervalFromTimeString:self.mp.informationModel.timestamp];
    self.createAt = [[UILabel alloc] init];
    self.createAt.frame = self.mp.createAt;
    self.createAt.font = TextFont_15;
    self.createAt.text = time;
    self.createAt.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.createAt];
}
- (void)iconTapped:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(pictureCell:iconTapped:) withObject:self withObject:tgr];
}
#pragma mark - LYPhotoViewDelegate
- (void)imageTappedByController:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(pictureCell:imageTapped:) withObject:self withObject:tgr];
}

@end
