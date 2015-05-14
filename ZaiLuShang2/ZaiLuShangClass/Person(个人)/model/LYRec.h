//
//  LYRec.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOwner.h"

@interface LYRec : NSObject

@property (nonatomic, copy) NSString *picid;
@property (nonatomic, copy) NSString *tourid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *location;

/**
 *  owner
 */
@property (nonatomic, strong) LYOwner *owner;

@property (nonatomic, copy) NSString *picdomain;
@property (nonatomic, copy) NSString *picfile;
@property (nonatomic, copy) NSString *pcolor;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *pictime;
@property (nonatomic, copy) NSString *lastedit;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *tourOwnerId;
@property (nonatomic, copy) NSString *mtime;
@property (nonatomic, copy) NSString *isPrivate;
@property (nonatomic, copy) NSString *picw;
@property (nonatomic, copy) NSString *pich;
@property (nonatomic, copy) NSString *picTag;
@property (nonatomic, copy) NSString *dispCity;
@property (nonatomic, copy) NSString *tourtitle;
@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, strong) NSNumber *isSticker;
@property (nonatomic, copy) NSString *sticker_id;
@property (nonatomic, copy) NSString *video_file_640;
@property (nonatomic, copy) NSString *dispDest;
/**
 *  评论数组
 */
@property (nonatomic, strong)NSMutableArray *comments;





@end
