//
//  LYCommentFrameModel.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYComment.h"
#import "LYOwner.h"

@interface LYCommentFrameModel : NSObject
@property (nonatomic, assign) LYComment *cmt;
@property (nonatomic, assign) CGFloat  cellHeight;

@property (nonatomic, assign) CGRect  icon;
@property (nonatomic, assign) CGRect  title;
@property (nonatomic, assign) CGRect  time;
@property (nonatomic, assign) CGRect  words;
- (instancetype)initWithCommentModel:(LYComment *)comment;
@end
