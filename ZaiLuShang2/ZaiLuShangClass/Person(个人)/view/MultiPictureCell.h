//
//  MultiPictureCell.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"

@interface MultiPictureCell : RootTableViewCell



@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UIImageView *photo;

@property (nonatomic, strong) UILabel *createAt;
@end
