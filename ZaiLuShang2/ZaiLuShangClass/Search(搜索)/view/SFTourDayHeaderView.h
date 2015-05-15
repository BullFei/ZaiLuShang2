//
//  SFTourDayHeaderView.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFTourDayInfo;
@interface SFTourDayHeaderView : UIView
+(SFTourDayHeaderView *)headerView;
@property (nonatomic,strong) SFTourDayInfo * tourDayInfo;

@end
