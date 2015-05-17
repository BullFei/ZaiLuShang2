//
//  CXCmtTableHeaderView.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXCmtTableHeaderView.h"
#import "UIImageView+WebCache.h"
#import "CXCollectionVCellOwnerModel.h"
#import "CXCollectionVCellModel.h"
#import "NSString+CXDataStr.h"

@interface CXCmtTableHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wordImageView;

@end

@implementation CXCmtTableHeaderView

+ (CXCmtTableHeaderView *)tableHeaderView
{
    CXCmtTableHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"CXCmtTableHeaderView" owner:nil options:nil] lastObject];
    UIImage *image = [UIImage imageNamed:@"bg_map_pic.9"];
    view.wordImageView.image = [image stretchableImageWithLeftCapWidth:CGW(view.wordImageView)/2 topCapHeight:CGH(view.wordImageView)/2];
    view.wordLabel.textAlignment = NSTextAlignmentCenter;
    return view;
}


- (void)setModel:(CXCollectionVCellModel *)model
{
    _model = model;
    CXCollectionVCellOwnerModel *user = model.owner;
    
    NSString *icon = [NSString stringWithFormat:@"%@%@%@",user.picdomain, SMALL_HEAD, user.avatar];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"icon_user_line_48_white"]];
    
    NSString *photo = [NSString stringWithFormat:@"%@%@%@",model.picdomain, SMALL_IMAGE, model.picfile];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    
    self.nameLabel.text = user.nickname;
    self.timeLabel.text = [model.timestamp toDataStr];
    self.wordLabel.text = model.words;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.iconView.layer.cornerRadius = CGW(self.iconView)/2;
    self.iconView.layer.masksToBounds = YES;
}

@end
