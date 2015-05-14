//
//  SFTabbarButton.m
//  SFWeibo
//
//  Created by qianfeng on 15-4-3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
//图标的比例
#define SFTabbarButtonImageRadio 0.6
//按钮的文字颜色
#define SFTabbarButtonTitleColor (ios7?[UIColor blackColor]:[UIColor whiteColor])
//按钮选中的文字颜色
#define SFTabbarButtonTitleSelectedColor (ios7? SFColor(234,139,0) : SFColor(248,139,0))

#import "SFCustomeButton.h"
@interface SFCustomeButton()

@end

@implementation SFCustomeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW =contentRect.size.width;
    CGFloat imageH =contentRect.size.height*SFTabbarButtonImageRadio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*SFTabbarButtonImageRadio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}



@end
