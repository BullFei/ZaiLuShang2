//
//  SFSceneryObjModel.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFCityTypeListModel;
@interface SFSceneryObjModel : NSObject
@property (nonatomic,strong) SFCityTypeListModel * scenery;
@property (nonatomic,strong) NSArray * bannerArray;
@property (nonatomic,assign) NSInteger myScore;
@property (nonatomic,copy) NSString *wiki_url;
@property (nonatomic,strong) NSArray * tipUserArray;



@end
