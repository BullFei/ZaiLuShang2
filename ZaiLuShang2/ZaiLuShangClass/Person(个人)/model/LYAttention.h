//
//  LYAttention.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYAttentionModel.h"

@interface LYAttention : NSObject

// 拥有一条信息模型
@property (nonatomic, strong) LYAttentionModel *lyam;
// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

/*******************************************************/

// 头像的frame
@property (nonatomic, assign) CGRect icon;

// 头部标题
@property (nonatomic, assign) CGRect titleName;

// 图片

// 正文

@end
