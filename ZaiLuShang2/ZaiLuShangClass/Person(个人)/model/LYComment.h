//
//  LYComment.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOwner.h"

@interface LYComment : NSObject

@property (nonatomic, copy) NSString *cmtid;
/**
 *  用户,和owner是一样的
 */
@property (nonatomic, strong) LYOwner *user;

@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *onitemid;
@property (nonatomic, copy) NSString *onitemtype;
@property (nonatomic, copy) NSString *replycmtid;
@property (nonatomic, copy) NSString *ontext;
@property (nonatomic, copy) NSString *rootreplyid;
@property (nonatomic, copy) NSString *rootitemid;
@property (nonatomic, copy) NSString *star;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, assign) BOOL  isLiked;

@end
