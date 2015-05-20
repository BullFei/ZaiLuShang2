//
//  SFTourDay.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDay.h"
#import "MJExtension.h"
#import "SFPathMap.h"
#import "SFItinerary.h"
@implementation SFTourDay
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

-(NSDictionary *)objectClassInArray
{
    return @{@"PathMap":[SFPathMap class],@"itinerary":[SFItinerary class]};
}


@end
