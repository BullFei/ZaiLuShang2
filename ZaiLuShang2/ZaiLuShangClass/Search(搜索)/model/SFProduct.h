//
//  SFProduct.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFProduct : NSObject
@property (nonatomic,copy) NSString *id;
@property (nonatomic,assign) BOOL isOrder;
@property (nonatomic,assign)NSInteger productid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picdomain;
@property (nonatomic,copy) NSString *picurl;
@property (nonatomic,copy) NSString *priceOri;
@property (nonatomic,copy) NSString *priceNow;
@property (nonatomic,copy) NSString *purchaseDate;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *markerColor;
@property (nonatomic,copy) NSString *marker;
@property (nonatomic,copy) NSString *subName;
@end
