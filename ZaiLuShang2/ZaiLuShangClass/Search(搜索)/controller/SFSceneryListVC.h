//
//  SFSceneryListVC.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFSearchDisplayModule,SFCityTypeListModel;
@interface SFSceneryListVC : UIViewController
@property (nonatomic,strong) SFSearchDisplayModule * displayModule;
@property (nonatomic,strong) SFCityTypeListModel *cityTypeListModel;
@end
