//
//  CXCollectionVCell.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXCollectionVCell.h"
#import "UIImageView+WebCache.h"
//#import "SFImageView.h"

@interface CXCollectionVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *cmtLabel;


@end

@implementation CXCollectionVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(CXCollectionVCellModel *)model
{
    _model = model;
    self.cmtLabel.text = model.cntcmt;
    NSString *str = [NSString stringWithFormat:@"%@b300/%@", model.picdomain, model.picfile];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
}


@end
