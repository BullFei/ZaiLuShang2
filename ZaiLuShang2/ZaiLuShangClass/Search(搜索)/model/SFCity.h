//
//  SFCity.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCity : NSObject
@property (nonatomic,assign) NSUInteger cityid;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,assign) NSUInteger  localityid;
@property (nonatomic,copy) NSString *district;
@property (nonatomic,assign) CGFloat lat;
@property (nonatomic,assign) CGFloat lng;
@end
