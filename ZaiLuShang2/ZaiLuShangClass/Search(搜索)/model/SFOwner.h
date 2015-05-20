//
//  SFOwner.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFOwner : NSObject
@property (nonatomic,copy) NSString *lastword;
@property (nonatomic,copy) NSString *selfintro;
@property (nonatomic,assign) NSUInteger followStatus;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *badge;
@property (nonatomic,assign) NSUInteger phonecode;
@property (nonatomic,copy) NSString *countryCode;
@end
