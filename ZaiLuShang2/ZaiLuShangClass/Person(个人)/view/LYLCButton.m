//
//  LYLCButton.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYLCButton.h"

@implementation LYLCButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置圆角
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        // 设置边框颜色
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        // 字体的大小和颜色
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

@end
