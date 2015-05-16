//
//  SFTourDayTitleView.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFItinerary;
@interface SFTourDayTitleView : UIView
@property (nonatomic,strong) SFItinerary * itinerary;

+(SFTourDayTitleView *)titleView;
@end
