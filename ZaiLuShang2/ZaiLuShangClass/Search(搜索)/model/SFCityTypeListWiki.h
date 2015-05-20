//
//  SFCityTypeListWiki.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCityTypeListWiki : NSObject
@property (nonatomic,assign) NSInteger wikitype;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger rawid;
@property (nonatomic,strong) NSArray * values;
@property (nonatomic,copy) NSString *title;

@end
