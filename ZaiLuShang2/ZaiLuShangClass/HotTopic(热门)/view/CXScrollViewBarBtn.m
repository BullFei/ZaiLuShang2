//
//  CXScrollViewBarBtn.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXScrollViewBarBtn.h"

@implementation CXScrollViewBarBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self setTitleColor:CXColor(240, 120, 90) forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat H = 10;
    return CGRectMake(0, CGH(self) - H - 5, CGW(self), H);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W = 35;
    CGFloat H = 48/68.0*W;
    return CGRectMake((CGW(self)-W)/2, 5, W, H);
}

@end
