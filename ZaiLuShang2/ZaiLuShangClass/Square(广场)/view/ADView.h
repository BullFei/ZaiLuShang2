//
//  ADView.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADModel.h"
@interface ADView : UIView <UIScrollViewDelegate>
+(ADView *)createADViewWithFrame:(CGRect)frame;
@property (nonatomic,weak)NSArray * ADModelArray;
@end
