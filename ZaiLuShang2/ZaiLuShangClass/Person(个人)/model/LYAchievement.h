//
//  LYAchievement.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYAttentionModel.h"

@interface LYAchievement : NSObject
// 拥有一条信息模型
@property (nonatomic, strong) LYAttentionModel *lyam;
// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

/*******************************************************/
@property (nonatomic, assign) CGRect icon;
@property (nonatomic, assign) CGRect author;
@property (nonatomic, assign) CGRect event;
@property (nonatomic, assign) CGRect ig;
@property (nonatomic, assign) CGRect medal;
@property (nonatomic, assign) CGRect condition;
@property (nonatomic, assign) CGRect createAt;


- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)model;

@end
