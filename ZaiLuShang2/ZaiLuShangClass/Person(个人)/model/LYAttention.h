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

// 作者
@property (nonatomic, assign) CGRect author;

// 中间连接的事件
@property (nonatomic, assign) CGRect event;

// 头部标题
@property (nonatomic, assign) CGRect titleName;

// 图片
@property (nonatomic, assign) CGRect ig;

// 正文
@property (nonatomic, assign) CGRect content;

// 喜欢
@property (nonatomic, assign) CGRect likeCnt;

// 评论
@property (nonatomic, assign) CGRect cmtCnt;

// 发布时间
@property (nonatomic, assign) CGRect createAt;

- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)model;
@end
