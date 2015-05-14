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
#import "SFCityTypeListModel.h"
#import "SFSceneryObjModel.h"
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

-(void)setSceneryObjModel:(SFSceneryObjModel *)sceneryObjModel
{
    if (sceneryObjModel) {
        _sceneryObjModel =sceneryObjModel;
        SFCityTypeListModel * cityTypeListModel =sceneryObjModel.scenery;
        SFCityTypeHeaderPicShow * cityTypeHeaderPicShow =cityTypeListModel.cityTypeHeaderPicShow;
        //大图
        NSString * url = [NSString stringWithFormat:@"%@/f1400/%@",cityTypeHeaderPicShow.picdomain,cityTypeHeaderPicShow.picfile];
        [self.photoImge sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder"]];
    
        
        self.titleLabel.text =cityTypeListModel.name;
        self.englishLabel.text =cityTypeListModel.name_en;
        NSArray * array =cityTypeListModel.pathArray;
        NSMutableArray * cityArray = [[NSMutableArray alloc]init];
        for (SFCityTypeHeaderPath * path  in array) {
            [cityArray addObject: path.dispname];
        }
        self.cityLabel.text = [cityArray componentsJoinedByString:@","];
        self.nameLabel.text =cityTypeListModel.copyright;
        
        //评分

    }
}


- (IBAction)smallBtnClick:(id)sender {
}
- (IBAction)photoBtnClick:(id)sender {
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*HUANGJINGSHU*HUANGJINGSHU);
    self.titleView.center =CGPointMake(self.center.x, self.center.y-20);
}
@end
