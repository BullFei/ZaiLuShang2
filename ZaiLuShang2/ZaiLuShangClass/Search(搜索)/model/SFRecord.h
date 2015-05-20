//
//  SFRecord.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFLocation,SFCityTypeHeadTipUser,SFOwner;
@interface SFRecord : NSObject
@property (nonatomic,copy) NSString *UUID;

@property (nonatomic,copy) NSString *picid;
@property (nonatomic,copy) NSString *tourid;
@property (nonatomic,copy) NSString *userid;

//@property (nonatomic,strong) SFLocation * location;

@property (nonatomic,strong) SFCityTypeHeadTipUser *owner;
 
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *picfile;
@property (nonatomic,copy) NSString *words;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *pictime;
@property (nonatomic,copy) NSString *lastedit;
 
@property (nonatomic,copy) NSString *cntcmt;
@property (nonatomic,copy) NSString *likeCnt;
@property (nonatomic,copy) NSString *tourOwnerId;
@property (nonatomic,copy) NSString * mtime;
@property (nonatomic,copy) NSString * picw;
@property (nonatomic,copy) NSString * pich;
@property (nonatomic,assign) NSUInteger picTag;
@property (nonatomic,copy) NSString * dispCity;
@property (nonatomic,copy) NSString * tourtitle;
@property (nonatomic,assign) BOOL isLiked;
@property (nonatomic,assign) NSUInteger isSticker;

/*
@property (nonatomic,copy) NSString *manualState;
@property (nonatomic,copy) NSString *showState;
@property (nonatomic,copy) NSString *showState2;



@property (nonatomic,assign) NSInteger pcolor;

//@property (nonatomic,strong) NSArray * tagArr;





@property (nonatomic,copy) NSString * sticker_id;
@property (nonatomic,copy) NSString * stickerTags;
//@property (nonatomic,strong) NSArray * stickerTagsArr;
*/
@end
