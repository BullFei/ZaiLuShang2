//
//  CXCmtCell.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXCmtCell.h"
#import "CXCmtFrameModel.h"
#import "CXCmtModel.h"
#import "UIImageView+WebCache.h"
#import "CXCollectionVCellOwnerModel.h"
#import "NSString+CXDataStr.h"

@interface CXCmtCell ()

@property (nonatomic ,weak) UIImageView *iconView;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *timeLabel;
@property (nonatomic ,weak) UILabel *text;

@property (nonatomic ,weak) UIView *bottemView;

@end

@implementation CXCmtCell

+ (CXCmtCell *)cmtCellWithTableView:(UITableView *)tableView
{
    CXCmtCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXCmtCell"];
    if (cell == nil) {
        cell = [[CXCmtCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CXCmtCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return  self;
}

- (void)createUI
{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    iconView.layer.masksToBounds = YES;
    self.iconView = iconView;
    
    UILabel *nameLabel = [self createLabel];
    nameLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [self createLabel];
    timeLabel.font = [UIFont systemFontOfSize:TIME_FONT];
    self.timeLabel = timeLabel;
    
    UILabel *textLabel = [self createLabel];
    textLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    self.text = textLabel;
    
    UIView *bottemView = [[UIView alloc] init];
    bottemView.backgroundColor = CXColorP(200, 200, 200, 0.5);
    self.bottemView = bottemView;
    [self addSubview:bottemView];
}

- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    
    return label;
}

- (void)setModel:(CXCmtFrameModel *)model
{
    _model = model;
    
    self.iconView.frame = model.imageViewF;
    self.nameLabel.frame = model.nickNameF;
    self.timeLabel.frame = model.timeF;
    self.text.frame = model.textLabelF;
    
    CXCmtModel *cmtModel = model.cmtModel;
    CXCollectionVCellOwnerModel *user = cmtModel.user;
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@", user.picdomain, SMALL_HEAD, user.avatar];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_user_line_48_white"]];
    self.nameLabel.text = user.nickname;
    self.timeLabel.attributedText = [cmtModel.timestamp toDataStr];
    self.text.text = cmtModel.words;
    
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.bottemView.frame = CGRectMake(self.text.frame.origin.x, CGH(self)-1, CGW(self), 1);
}

@end
