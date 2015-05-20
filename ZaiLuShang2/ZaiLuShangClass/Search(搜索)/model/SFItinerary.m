//
//  SFItinerary.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFItinerary.h"
#import "MJExtension.h"
#import "SFCity.h"
#import "SFItem.h"
@implementation SFItinerary
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

-(NSDictionary *)objectClassInArray
{
    return @{@"cities":[SFCity class],@"items":[SFItem class]};
}
@end
