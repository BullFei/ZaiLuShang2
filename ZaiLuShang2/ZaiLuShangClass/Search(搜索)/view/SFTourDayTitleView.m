
//
//  SFTourDayTitleView.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDayTitleView.h"
#import "SFItinerary.h"
@interface SFTourDayTitleView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SFTourDayTitleView
+(SFTourDayTitleView *)titleView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SFTourDayTitleView" owner:nil options:nil]lastObject];
}

-(void)setItinerary:(SFItinerary *)itinerary
{
    if (itinerary) {
        _itinerary = itinerary;
        self.titleLabel.text = [NSString stringWithFormat:@"第%@天  %@",itinerary.day,itinerary.date];
    }
}

@end
