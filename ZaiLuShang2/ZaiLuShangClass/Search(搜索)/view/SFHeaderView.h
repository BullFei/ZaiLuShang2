//
//  SFHeaderView.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHead,SFSceneryObjModel,SFHeaderView;
@protocol SFHeaderViewDelegate <NSObject>

-(void)headerView:(SFHeaderView *)headerView pushController:(UIViewController *)controller;

@end

@interface SFHeaderView : UIView
+(SFHeaderView *)headerView;
@property (nonatomic,strong) SFCityTypeHead * cityTypeHead;
@property (nonatomic,strong) SFSceneryObjModel * sceneryObjModel;
@property (nonatomic,assign) id<SFHeaderViewDelegate> delegate;
@end
