//
//  SFCityTypeListModel.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFCityTypeListLoc,SFCityTypeHeadTag,SFCityTypeHeaderPicShow,SFCityTypeListStaticMap;
@interface SFCityTypeListModel : NSObject
@property (nonatomic,strong) SFCityTypeListLoc * cityTypeListLoc;
@property (nonatomic,assign) NSInteger stickerCnt;
@property (nonatomic,assign) NSInteger tourCnt;
@property (nonatomic,assign) NSInteger goneCnt;
@property (nonatomic,assign) NSInteger wantCnt;
@property (nonatomic,assign) NSInteger likeCnt;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *pathstr;
@property (nonatomic,assign) BOOL isWanted;
@property (nonatomic,assign) BOOL isVisited;
@property (nonatomic,assign) NSInteger picCnt;
@property (nonatomic,assign) NSInteger myScore;
@property (nonatomic,strong) NSArray * wikiArray;
@property (nonatomic,assign)NSInteger myscore;
@property (nonatomic,strong) SFCityTypeHeadTag * cityTypeHeadTag;
@property (nonatomic,copy) NSString *copyright;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *name_en;
@property (nonatomic,strong) SFCityTypeHeaderPicShow * cityTypeHeaderPicShow;
@property (nonatomic,assign) CGFloat *score;
@property (nonatomic,strong) NSArray * pathArray;
@property (nonatomic,strong) SFCityTypeListStaticMap * cityTypeListStaticMap;





@end
