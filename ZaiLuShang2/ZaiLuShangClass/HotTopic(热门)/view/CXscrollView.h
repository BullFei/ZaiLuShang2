//
//  CXscrollView.h
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXscrollView : UIView


// 设置数据源 没有自动滚动功能 不创建定时器
- (void)setImageUrlNames:(NSArray *)ImageUrlNames index:(NSIndexPath *)index;
// 设置数据源 和 自动滚动时间 能够自动滚动
- (void)setImageUrlNames:(NSArray *)ImageUrlNames index:(NSIndexPath *)index animationDuration:(NSTimeInterval)animationDuration;

@end
