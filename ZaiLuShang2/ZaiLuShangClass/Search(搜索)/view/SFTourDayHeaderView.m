//
//  SFTourDayHeaderView.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDayHeaderView.h"
#import "SFTourDayInfo.h"
#import "UIImageView+WebCache.h"
#import "SFOwner.h"
#import "LYWebViewController.h"
@interface SFTourDayHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *textImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
- (IBAction)iconClick:(id)sender;
@end

@implementation SFTourDayHeaderView
{
    CGSize textSize;
}
+(SFTourDayHeaderView *)headerView
{
    return[[[NSBundle mainBundle]loadNibNamed:@"SFTourDayHeaderView" owner:nil options:nil]lastObject];
}

-(void)setTourDayInfo:(SFTourDayInfo *)tourDayInfo
{
    if(tourDayInfo){
        _tourDayInfo =tourDayInfo;
        //背景图片
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",tourDayInfo.picdomain,tourDayInfo.coverpic]] placeholderImage:nil];
        //头像
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ava/%@",tourDayInfo.owner.picdomain,tourDayInfo.owner.avatar]] placeholderImage:nil];
        //title
        
        self.titleLabel.text =tourDayInfo.title;
        self.peopleLabel.text =tourDayInfo.owner.nickname;
        self.dateLabel.text = [NSString stringWithFormat:@"%@|%@",tourDayInfo.startdate,tourDayInfo.days];
        self.tagLabel.text =tourDayInfo.tags;
        
       
        self.textView.text =tourDayInfo.foreword;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.tourDayInfo) {
        textSize =[TextSizeTools sizeWithString: self.tourDayInfo.foreword withMaxSize:CGSizeMake(SCREEN_WIDTH-16-16, MAXFLOAT) withFont:TextFont_15];
    }
    
    //更改图片大小
    CGRect bgImageFrame =self.bgImageView.frame;
    bgImageFrame.size.height = SCREEN_WIDTH*HUANGJINGSHU;
    self.bgImageView.frame =bgImageFrame;
    //更改view大小
    CGFloat height = self.bgImageView.frame.size.height+textSize.height+20;
    
    self.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width*0.5;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.textImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textImageView.layer.borderWidth = 1;
    
    if ([self.delegate respondsToSelector:@selector(tourDayHeaderView:height:)]) {
        [self.delegate tourDayHeaderView:self height:height];
    }
    
}
- (IBAction)iconClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tourDayHeaderView:pushController:)]) {
        LYWebViewController *vc = [[LYWebViewController alloc]init];
        SFTourDayInfo * tourDayInfo =self.tourDayInfo;
        vc.userid = tourDayInfo.owner.userid;
        vc.pageType = WebViewPageTypeUser;
        [self.delegate tourDayHeaderView:self pushController:vc];

    }
    
}
@end
