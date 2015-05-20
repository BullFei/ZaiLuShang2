//
//  CommentModel.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewerModel.h"
@interface CommentModel : NSObject
@property (nonatomic,copy)NSString * ontext;//评论对象
@property (nonatomic,copy)NSString * words; //评论的话
@property (nonatomic,strong)ReviewerModel * user;
@end
