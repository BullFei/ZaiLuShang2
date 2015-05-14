//
//  BadgeButten.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/14.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import "BadgeButten.h"

@implementation BadgeButten

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
//        [self setBackgroundImage:[UIImage imageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue.length != 0 && [badgeValue intValue] != 0) {
        self.hidden = NO;
        
        [self setTitle:badgeValue forState:UIControlStateNormal];
        // 图片算尺寸
//        CGRect frame = self.frame;
//        CGSize imageSize = self.currentBackgroundImage.size;
//        if (badgeValue.length > 1) {
//            CGSize badgeSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
//            imageSize.width = badgeSize.width + 10;
//        }
//        frame.size.width = imageSize.width;
//        frame.size.height = imageSize.height;
//        self.frame = frame;
        
        // 文字
        CGRect frame = self.frame;
        CGSize size = [_badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        frame.size.height = size.height;
        frame.size.width = (size.width + 4 > size.height ? size.width + 4 : size.height);
        
        self.frame = frame;
        self.layer.cornerRadius = size.height/2;
        self.layer.masksToBounds = YES;
    } else {
        self.hidden = YES;
    }
}

@end
