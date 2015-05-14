//
//  TripCell.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"
#import "STTweetLabel.h"

@interface TripCell : RootTableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) STTweetLabel *titleLabel;
@property (nonatomic, strong) UIImageView *ig;



- (instancetype)init;
@end
