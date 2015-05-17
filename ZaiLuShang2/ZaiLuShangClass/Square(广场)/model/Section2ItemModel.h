//
//  Section2ItemModel.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewerModel.h"
@interface Section2ItemModel : NSObject
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * picdomain;
@property (nonatomic,copy)NSString * coverpic;
@property (nonatomic,strong)ReviewerModel * owner;
@end
