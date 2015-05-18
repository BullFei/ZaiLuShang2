//
//  LYPhotoView.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYPhotoView.h"
#import "UIImageView+WebCache.h"

#define LYZLS_IMAGE_INTERVAL 5
#define LYZLS_ICON_WIDTH 102
#define LYZLS_IMAGE_WIDTH ((self.frame.size.width - 2 * LYZLS_IMAGE_INTERVAL)/3)
#define LYZLS_IMAGE_TAG 100


@implementation LYPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
- (void)configImages {
    // 得到图片的数量,计算能够创建几行图片
    NSInteger index = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            
            UIImageView *iv = [[UIImageView alloc] init];
            // 打开用户交互
            iv.userInteractionEnabled = YES;
            // 先进行判断
            if (index > self.imageCount) {
                iv.frame = CGRectZero;
            } else {
                iv.frame = CGRectMake((LYZLS_IMAGE_WIDTH + LYZLS_IMAGE_INTERVAL)*j, (LYZLS_IMAGE_WIDTH + LYZLS_IMAGE_INTERVAL)*i, LYZLS_IMAGE_WIDTH, LYZLS_IMAGE_WIDTH);
            }
            
            iv.tag = LYZLS_IMAGE_TAG + index;
            [self addSubview:iv];
            index++;
            // 添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
            [iv addGestureRecognizer:tap];
            
            if (self.imageCount > 9) {
                // 添加"更多"按钮
                [self addMoreButton];
            }
        }
    }
    [self getImagesWithURLS];
}
- (void)addMoreButton {
    
}
- (void)getImagesWithURLS {
        for (int i = 0; i < self.imageCount; i++) {
            if (i >= 9) {
                break;
            }
            UIImageView *iv = (UIImageView *)[self viewWithTag:LYZLS_IMAGE_TAG + i];
            [iv sd_setImageWithURL:[NSURL URLWithString:self.imageURLS[i]]];
        }
}
- (void)imageTapped:(UITapGestureRecognizer *)tgr {
    [self.delegate performSelector:@selector(imageTappedByController:) withObject:tgr];
}
@end
