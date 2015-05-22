//
//  SFCityTypeHeadLocality.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFCityTypeHeadTag,SFCityTypeHeaderPath,SFCityTypeHeaderPicShow;
@interface SFCityTypeHeadLocality : NSObject
@property (nonatomic,assign) BOOL isWanted;
@property (nonatomic,assign) BOOL isVisited;
@property (nonatomic,assign) NSInteger tourCnt;//游记
@property (nonatomic,assign) NSInteger picCnt;
@property (nonatomic,assign) NSInteger stickerCnt;//贴士
@property (nonatomic,assign) NSInteger sceneryCnt;
@property (nonatomic,copy) NSString *copyright;//ren
@property (nonatomic,strong) SFCityTypeHeadTag * cityTypeHeadTag;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *countryid;
@property (nonatomic,copy) NSString *dispname;
@property (nonatomic,copy) NSString *dispname_en;
@property (nonatomic,copy) NSString *fullname;
@property (nonatomic,copy) NSString *fullname_en;
@property (nonatomic,assign) CGFloat lat;
@property (nonatomic,assign) CGFloat lng;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,strong) NSMutableArray * paths;
@property (nonatomic,assign) NSInteger linkCnt;
@property (nonatomic,assign) NSInteger visitedCnt;
@property (nonatomic,assign) NSInteger wantCnt;
@property (nonatomic,assign) NSInteger pv;
@property (nonatomic,assign) NSInteger pgcCnt;
@property (nonatomic,strong) SFCityTypeHeaderPicShow * cityTypeHeaderPicShow;



@end
