//
//  IconCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "IconCell.h"
#import "LYComment.h"
#import "UIImageView+WebCache.h"

#define LYZLS_IMAGE_INTERVAL 5
#define LYZLS_IMAGE_WIDTH 30

@implementation IconCell
- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configUIWithArray:(NSArray *)array {
    
    // 获取所有头像的URL
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (LYComment *comment in array) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@", comment.user.picdomain, SMALL_HEAD, comment.user.avatar];
        [tempArray addObject:url];
    }
    NSInteger count = array.count;
    if (count >= 5) {
        count = 6;
    }
    for (int i = 0; i < count; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(LYZLS_IMAGE_INTERVAL + (LYZLS_IMAGE_INTERVAL + LYZLS_IMAGE_WIDTH)*i, 2*LYZLS_IMAGE_INTERVAL, LYZLS_IMAGE_WIDTH, LYZLS_IMAGE_WIDTH);
        iv.layer.cornerRadius = LYZLS_IMAGE_WIDTH/2;
        iv.layer.masksToBounds = YES;
        [self.contentView addSubview:iv];
        
        if (i == 5) {
            iv.image = [UIImage imageNamed:@"icon_more_gray_32"];
        } else {
            [iv sd_setImageWithURL:[NSURL URLWithString:tempArray[i]] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((LYZLS_IMAGE_WIDTH + LYZLS_IMAGE_INTERVAL) * 6 + 2 * LYZLS_IMAGE_INTERVAL, 2 * LYZLS_IMAGE_INTERVAL, 100, LYZLS_IMAGE_WIDTH)];
    label.text = [NSString stringWithFormat:@"%ld个赞", (unsigned long)array.count];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = TextFont_15;
    [self.contentView addSubview:label];
    
    //cell分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 1, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}

@end
