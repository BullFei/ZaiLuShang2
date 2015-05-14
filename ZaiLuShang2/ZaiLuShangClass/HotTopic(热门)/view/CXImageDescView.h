//
//  CXImageDescView.h
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXCollectViewCellModel;

@interface CXImageDescView : UIView
@property (nonatomic ,strong) CXCollectViewCellModel *model;

@property (nonatomic ,weak) SFImageView *imageView;

- (void)setModel:(CXCollectViewCellModel *)model isLoadImage:(BOOL)is;

- (void)setModel:(CXCollectViewCellModel *)model isLoadImage:(BOOL)is success:(void (^)())success;
@end
