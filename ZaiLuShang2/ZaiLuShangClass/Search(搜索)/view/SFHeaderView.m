//
//  SFHeaderView.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFHeaderView.h"
#import "UIImageView+WebCache.h"
#import "SFCityTypeHeaderPicShow.h"
#import "SFCityTypeHeadLocality.h"
#import "SFCityTypeHead.h"
#import "SFCityTypeHeaderPath.h"
@interface SFHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)smallBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *smallBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoImge;
- (IBAction)photoBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

@end

@implementation SFHeaderView

+(SFHeaderView *)headerView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SFHeaderView" owner:nil options:nil]lastObject];
}

-(void)setCityTypeHead:(SFCityTypeHead *)cityTypeHead
{
    if (cityTypeHead) {
        _cityTypeHead =cityTypeHead;
        SFCityTypeHeaderPicShow * cityTypeHeaderPicShow =cityTypeHead.cityTypeHeadLocality.cityTypeHeaderPicShow;
        NSString * url = [NSString stringWithFormat:@"%@/f1400/%@",cityTypeHeaderPicShow.picdomain,cityTypeHeaderPicShow.picfile];
        [self.photoImge sd_setImageWithURL:[NSURL URLWithString:url]];
        
        self.titleLabel.text =cityTypeHead.cityTypeHeadLocality.dispname;
        self.englishLabel.text =cityTypeHead.cityTypeHeadLocality.dispname_en;
        NSArray * array =cityTypeHead.cityTypeHeadLocality.paths;
        NSMutableArray * cityArray = [[NSMutableArray alloc]init];
        for (SFCityTypeHeaderPath * path  in array) {
            [cityArray addObject: path.dispname];
        }
        self.cityLabel.text = [cityArray componentsJoinedByString:@","];
        self.nameLabel.text =cityTypeHead.cityTypeHeadLocality.copyright;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*HUANGJINGSHU*HUANGJINGSHU);
    
    
}
- (IBAction)smallBtnClick:(id)sender {
}
- (IBAction)photoBtnClick:(id)sender {
}
@end
