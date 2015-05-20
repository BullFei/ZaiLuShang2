//
//  SFTourDayInfo.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFOwner;
@interface SFTourDayInfo : NSObject
@property (nonatomic,strong) NSArray * records;
@property (nonatomic,strong) NSArray * PathMap;
@property (nonatomic,strong) NSArray * products;
@property (nonatomic,assign) BOOL  day_header;
@property (nonatomic,strong) NSArray * members;
@property (nonatomic,copy) NSString *myRole;
@property (nonatomic,copy) NSString *priority;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *foreword;
@property (nonatomic,copy) NSString *startdate;
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *coverpic;
@property (nonatomic,copy) NSString *subtype;
@property (nonatomic,copy) NSString *cntcmt;
@property (nonatomic,copy) NSString *cntP;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *cntFav;
@property (nonatomic,copy) NSString *isPrivate;
@property (nonatomic,copy) NSString *cntMember;
@property (nonatomic,copy) NSString *isTeam;
@property (nonatomic,copy) NSString *likeCnt;
@property (nonatomic,copy) NSString *mtime;
@property (nonatomic,copy) NSString *recmtime;
@property (nonatomic,copy) NSString *UUID;
@property (nonatomic,strong) NSArray * dispCities;
@property (nonatomic,assign) BOOL isCurrTrip;
@property (nonatomic,assign) BOOL isMyFav;
@property (nonatomic,assign) BOOL isLiked;
@property (nonatomic,copy) NSString *viewCnt;
@property (nonatomic,copy) NSString *days;
@property (nonatomic,copy) NSString *tags;
@property (nonatomic,strong) SFOwner * owner;

@end
