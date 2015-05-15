//
//  SpecialColumnView.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialColumnModel.h"
@interface SpecialColumnView : UIView
+(SpecialColumnView *)getSpecialColumnViewWithFrame:(CGRect)frame;
@property (nonatomic,weak)SpecialColumnModel * specialColumnModel;
@end
