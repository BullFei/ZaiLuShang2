//
//  JingXuanModel.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewerModel.h"
@interface JingXuanModel : NSObject
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * picdomain;
@property (nonatomic,copy)NSString * coverpic;
@property (nonatomic,copy)NSString * likeCnt;
@property (nonatomic,copy)NSString * cntP;
@property (nonatomic,strong)NSArray * cmt;//评论model的数组
//@property (nonatomic,copy)发布者（用户）model
//@property (nonatomic,copy)评论者（用户）model
@property (nonatomic,strong)ReviewerModel *  owner;
@end
