//
//  SFSceneryTypeFivtyCollectionViewCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSceneryTypeFivtyCollectionViewCell.h"
#import "SFCityTypeListModel.h"
#import "UIImageView+WebCache.h"
#import "SFCityTypeHeaderPicShow.h"
@interface SFSceneryTypeFivtyCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation SFSceneryTypeFivtyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCityTypeListModel:(SFCityTypeListModel *)cityTypeListModel
{
    if (cityTypeListModel) {
        _cityTypeListModel = cityTypeListModel;
        self.titleLabel.text =cityTypeListModel.name;
        
        SFCityTypeHeaderPicShow * cityTypeHeaderPicShow =cityTypeListModel.cityTypeHeaderPicShow;
        NSString * url = [NSString stringWithFormat:@"%@/f1400/%@",cityTypeHeaderPicShow.picdomain,cityTypeHeaderPicShow.picfile];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    }
}

@end
