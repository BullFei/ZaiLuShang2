//
//  SFCityType.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFCityTypeHeadLocality;
@interface SFCityType : NSObject
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,assign) BOOL hasMore;
@property (nonatomic,assign) NSInteger start;
@property (nonatomic,strong) SFCityTypeHeadLocality * cityTypeHeadLocality;
@end
