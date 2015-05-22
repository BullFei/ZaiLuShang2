//
//  SpecialColumnView.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialColumnModel.h"
#define GROUND_SPECIALCOLUMNVIEW_INIT_TAG 200
@interface SpecialColumnView : UIView
+(SpecialColumnView *)getSpecialColumnViewWithFrame:(CGRect)frame;
@property (nonatomic,weak)SpecialColumnModel * specialColumnModel;
@property (nonatomic,copy)void(^JingXuanPushBlock)(void);
@property (nonatomic,copy)void(^Section2PushBlock)(NSString * link);
@property (nonatomic,copy)void(^TripTopicPushBlock)(NSString * link);


@property (nonatomic,copy)void(^MoreThemePushBlock)(void);
@end
