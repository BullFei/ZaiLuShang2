//
//  MultiPictureCell.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"
#import "LYPhotoView.h"
#import "LYMultiPicture.h"

@interface MultiPictureCell : RootTableViewCell

// cell拥有一个frame模型
@property (nonatomic, strong) LYMultiPicture *mp;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) LYPhotoView *photo;
@property (nonatomic, strong) UILabel *createAt;

- (instancetype)initWithLYMultiPicture:(LYMultiPicture *)mp;
@end
