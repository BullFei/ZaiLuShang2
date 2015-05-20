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
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation CXCmtTableHeaderView

+ (CXCmtTableHeaderView *)tableHeaderView
{
    CXCmtTableHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"CXCmtTableHeaderView" owner:nil options:nil] lastObject];
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
    self.textView.text = model.words;
    if (model.words.length == 0) {
        self.textView.text = @"他(她)什么也没留下。";
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.iconView.layer.cornerRadius = CGW(self.iconView)/2;
    self.iconView.layer.masksToBounds = YES;
}

@end
