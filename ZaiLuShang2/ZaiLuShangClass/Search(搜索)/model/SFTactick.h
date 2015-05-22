//
//  SFTactick.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFTactickBanners.h"
@interface SFTactick : NSObject
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *coverpic;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,strong) SFTactickBanners * banner;

@end
