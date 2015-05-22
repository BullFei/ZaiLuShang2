//
//  TripTopicModel.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripTopicModel : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSNumber * stickercnt;
@property (nonatomic,copy)NSString  * picdomain;
@property (nonatomic,copy)NSString * coverpic;
@property (nonatomic,copy)NSNumber * tag_id;
//@property (nonatomic,copy)NSString * link;
@end
