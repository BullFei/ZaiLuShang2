//
//  LYItem.h
//  ZaiLuShang
//
//  Created by ChangLuyang on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOwner.h"
#import "LYTour.h"

@interface LYItem : NSObject

@property (nonatomic, copy) NSString *piccnt;
@property (nonatomic, strong) LYOwner *user;
@property (nonatomic, strong) LYTour *tour;

@end
