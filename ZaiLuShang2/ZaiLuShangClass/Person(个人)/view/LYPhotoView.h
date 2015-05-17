//
//  LYPhotoView.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYPhotoViewDelegate <NSObject>

- (void)imageTappedByController:(UITapGestureRecognizer *)tgr;

@end

@interface LYPhotoView : UIView

// 图片数量
@property (nonatomic, assign) NSInteger  imageCount;
// 图片的网络地址
@property (nonatomic, strong) NSMutableArray *imageURLS;

// 事件的代理 
@property (nonatomic) id <LYPhotoViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)configImages;

@end
