//
//  SFItinerary.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFItinerary : NSObject
@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,strong) NSArray * cities;
@property (nonatomic,strong) NSArray * items;

@end
