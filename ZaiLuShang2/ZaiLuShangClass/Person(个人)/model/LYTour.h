//
//  LYTour.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOwner.h"

@interface LYTour : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *foreword;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *cntP;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *picdomain;
@property (nonatomic, copy) NSString *coverpic;
@property (nonatomic, strong) NSNumber *pcolor;
@property (nonatomic, copy) NSString *subtype;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *cntFav;
@property (nonatomic, copy) NSString *isPrivate;
@property (nonatomic, copy) NSString *cntMember;
@property (nonatomic, copy) NSString *isTeam;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *mtime;
@property (nonatomic, copy) NSString *recmtime;
@property (nonatomic, copy) NSString *UUID;

@property (nonatomic, strong) LYOwner *owner;

@property (nonatomic, assign) BOOL  isCurrTrip;
@property (nonatomic, assign) BOOL  isMyFav;
@property (nonatomic, assign) BOOL  isLiked;
@property (nonatomic, copy) NSString *viewCnt;

@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *records;

@end
