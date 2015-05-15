//
//  SFTourDayCustomeModel.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFItinerary;
@interface SFTourDayCustomeModel : NSObject
@property (nonatomic,strong) SFItinerary * itinerary;
@property (nonatomic,strong) NSMutableArray * tourDayInfoArray;
@end
