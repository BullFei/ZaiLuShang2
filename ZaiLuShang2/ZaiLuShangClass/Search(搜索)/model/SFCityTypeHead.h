//
//  SFCityTypeHead.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFCityTypeHeadLocality;
@interface SFCityTypeHead : NSObject
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) SFCityTypeHeadLocality * cityTypeHeadLocality;
@property (nonatomic,copy) NSString *hotCnt;
@property (nonatomic,strong) NSMutableArray * tip_users;


@end
