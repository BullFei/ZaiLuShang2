//
//  TieShiModel.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewerModel.h"
@interface TieShiModel : NSObject
@property (nonatomic,assign)BOOL isLiked;
//@property (nonatomic,copy)NSString * likeCount;
@property (nonatomic,copy)NSString * cntcmt;
@property (nonatomic,copy)NSString * cntzan;
@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * lastupdate;
@property (nonatomic,copy)NSString * pic;
@property (nonatomic,copy)NSString * picdomain;
@property (nonatomic,strong)NSNumber * pich;
@property (nonatomic,strong)NSNumber * picw;
@property (nonatomic,strong)NSArray * pics;
@property (nonatomic,copy)NSString * sticker_id;
@property (nonatomic,copy)NSArray * tags;
@property (nonatomic,strong)ReviewerModel * user;
@property (nonatomic,copy)NSString * words;
@end
