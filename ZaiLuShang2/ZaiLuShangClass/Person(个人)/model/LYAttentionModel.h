//
//  LYAttentionModel.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  一条关注的信息模型
 */
@interface LYAttentionModel : NSObject

@property (nonatomic, copy) NSString *dyncid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *itemid;
@property (nonatomic, copy) NSString *items;

/**
 *  此处可能有3种类型,故而用id类型
 */
@property (nonatomic, strong) id item;



@end
