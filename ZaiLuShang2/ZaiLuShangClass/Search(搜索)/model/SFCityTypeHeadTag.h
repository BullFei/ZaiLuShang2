//
//  SFCityTypeHeadTag.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCityTypeHeadTag : NSObject
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *coverpic;
@property (nonatomic,assign) NSInteger stickercnt;
@property (nonatomic,copy) NSString *describe2;
@property (nonatomic,assign) NSInteger pgcCnt;
@property (nonatomic,assign) NSInteger upid;
@property (nonatomic,copy) NSString *pathstr;
@property (nonatomic,assign) NSInteger tag_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger main_id;
@property (nonatomic,assign) NSInteger itemid;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,copy) NSString *posterId;
@property (nonatomic,assign) NSInteger taoStatus;
@property (nonatomic,assign) BOOL isSubscribed;
@end
