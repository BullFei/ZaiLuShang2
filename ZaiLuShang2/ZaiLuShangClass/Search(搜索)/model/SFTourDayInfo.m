//
//  SFTourDayInfo.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDayInfo.h"
#import "MJExtension.h"
#import "SFOwner.h"
#import "SFCityTypeHeadTipUser.h"
#import "SFRecord.h"
#import "SFPathMap.h"
@implementation SFTourDayInfo
-(NSDictionary *)objectClassInArray
{
    return @{@"members":[SFCityTypeHeadTipUser class],@"records":[SFRecord class]};
    //@"records":[SFRecord class]
}

-(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end
