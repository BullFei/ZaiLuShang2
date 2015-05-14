//
//  SFUserIconView.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHeadTipUser;

@interface SFUserIconView : UIView
{
    UIButton * iconBtn;
}
@property (nonatomic,strong) SFCityTypeHeadTipUser * user;

@end
