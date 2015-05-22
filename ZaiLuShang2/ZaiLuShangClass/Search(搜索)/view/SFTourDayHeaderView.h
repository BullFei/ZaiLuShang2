//
//  SFTourDayHeaderView.h
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFTourDayInfo,SFTourDayHeaderView;
@protocol SFTourDayHeaderViewDelegate <NSObject>

-(void)tourDayHeaderView:(SFTourDayHeaderView*)view height:(CGFloat)height;
-(void)tourDayHeaderView:(SFTourDayHeaderView *)view pushController:(UIViewController *)controller;

@end
@interface SFTourDayHeaderView : UIView
+(SFTourDayHeaderView *)headerView;
@property (nonatomic,strong) SFTourDayInfo * tourDayInfo;
@property (nonatomic,assign) id<SFTourDayHeaderViewDelegate> delegate;



@end
