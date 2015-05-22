//
//  SFItem.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFItem : NSObject
@property (nonatomic,copy) NSString *poiid;
@property (nonatomic,assign) CGFloat lat;
@property (nonatomic,assign) CGFloat lng;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign)NSUInteger sceneryid;
@property (nonatomic,assign)NSUInteger sid;
@property (nonatomic,assign)NSUInteger type;
@property (nonatomic,copy) NSString * ID;
@property (nonatomic,assign)NSUInteger enable;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *picid;
@end
