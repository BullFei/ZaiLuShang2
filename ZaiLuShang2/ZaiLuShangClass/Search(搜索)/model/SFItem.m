//
//  SFItem.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFItem.h"
#import "MJExtension.h"
@implementation SFItem
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

-(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
