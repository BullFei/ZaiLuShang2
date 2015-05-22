//
//  RootTableViewCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
