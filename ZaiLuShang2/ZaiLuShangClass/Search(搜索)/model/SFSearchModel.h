//
//  SFSearchModel.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSearchModel : NSObject
@property (nonatomic,assign) int type;
@property (nonatomic,copy) NSString *showType;
@property (nonatomic,strong) NSMutableArray * listArray;
@end
