//
//  CXCmtFrameModel.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXCmtFrameModel.h"
#import "CXCmtModel.h"
#import "CXCollectionVCellOwnerModel.h"

#define ICONIMAGE_WIDTH 40


@implementation CXCmtFrameModel

- (void)setCmtModel:(CXCmtModel *)cmtModel
{
    _cmtModel = cmtModel;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 头像iconView
    CGFloat iconViewW = ICONIMAGE_WIDTH;
    CGFloat iconViewH = iconViewW;
    CGFloat iconViewX = IMAGEVIEW_BORDER;
    CGFloat iconViewY = 5;
    _imageViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // nameLabel
    CGSize nameLabelSize = [cmtModel.user.nickname sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:NAME_FONT]}];
    CGFloat nameLabelX = CGRectGetMaxX(_imageViewF)+NAME_IMAGEVIEW;
    CGFloat nameLabelY = iconViewY;
    _nickNameF = (CGRect){nameLabelX, nameLabelY, nameLabelSize};
    
    // 时间
    CGSize timeLabelSize = [cmtModel.timestamp sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TIME_FONT]}];
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_imageViewF)-timeLabelSize.height;
    _timeF = (CGRect){timeLabelX, timeLabelY, timeLabelSize};
    
    // 正文
    CGSize textMaxSize = CGSizeMake(cellW - CGRectGetMidX(_imageViewF)-IMAGEVIEW_BORDER, CGFLOAT_MAX);
    CGRect contentLabelRect = [cmtModel.words boundingRectWithSize:textMaxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TEXT_FONT]} context:nil];
    CGFloat contentLabelX = CGRectGetMidX(_imageViewF);
    CGFloat contentLabelY = CGRectGetMaxY(_imageViewF)+10;
    _textLabelF = (CGRect){contentLabelX, contentLabelY, textMaxSize.width, contentLabelRect.size.height};
    
    _cellH = CGRectGetMaxY(_textLabelF) + 10;
        
}

@end
