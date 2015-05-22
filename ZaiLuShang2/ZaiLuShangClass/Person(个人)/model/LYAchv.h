//
//  LYAchv.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOwner.h"

@interface LYAchv : NSObject

@property (nonatomic, strong) NSNumber *lv;
@property (nonatomic, copy) NSString *awarddate;
@property (nonatomic, strong) NSNumber *achv;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pic_mini;
@property (nonatomic, strong) NSNumber *next_value;
@property (nonatomic, strong) NSNumber *is_top;
@property (nonatomic, copy) NSString *next_desc;
@property (nonatomic, copy) NSString *current_value;
@property (nonatomic, copy) NSString *userid;

@property (nonatomic, strong) LYOwner *user;

@end
