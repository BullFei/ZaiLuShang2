//
//  LYMultiPicture.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYItem.h"
#import "LYAttentionModel.h"
#import "LYOwner.h"
#import "LYRec.h"   

@interface LYMultiPicture : NSObject

// 拥有一条信息模型
@property (nonatomic, strong) LYAttentionModel *informationModel;
// cell 的高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect icon;
@property (nonatomic, assign) CGRect author;
@property (nonatomic, assign) CGRect event;
@property (nonatomic, assign) CGRect title;
@property (nonatomic, assign) CGRect photoView;
@property (nonatomic, assign) CGRect createAt;

- (instancetype)initWithLYAttentionModel:(LYAttentionModel *)im;

@end
