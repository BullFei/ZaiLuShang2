//
//  SFSearchCountryCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSearchCountryCell.h"
#import "SFSearchDisplayModule.h"
#import "UIImageView+WebCache.h"
@interface SFSearchCountryCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
- (IBAction)rightBtnClick:(id)sender;
- (IBAction)leftBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabelLabel;

@end


@implementation SFSearchCountryCell

+(SFSearchCountryCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"countryCell";
    SFSearchCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFSearchCountryCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setDisplayModuleLeft:(SFSearchDisplayModule *)displayModuleLeft
{
    if (displayModuleLeft) {
        _displayModuleLeft = displayModuleLeft;
        NSString * url =[NSString stringWithFormat:@"%@/f1400/%@",displayModuleLeft.picdomain, displayModuleLeft.coverpic];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
        self.leftTitleLabel.text=displayModuleLeft.name;
    }
}

-(void)setDisplayModuleRight:(SFSearchDisplayModule *)displayModuleRight
{
    if (displayModuleRight) {
        _displayModuleRight = displayModuleRight;
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",displayModuleRight.picdomain, displayModuleRight.coverpic]] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
        self.rightLabelLabel.text =displayModuleRight.name;
    }
    
}


- (IBAction)rightBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(searchCountryCellPushController:withSearchDisplayModule:)]) {
        [self.delegate searchCountryCellPushController:self withSearchDisplayModule:self.displayModuleRight];
    }
}

- (IBAction)leftBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(searchCountryCellPushController:withSearchDisplayModule:)]) {
        [self.delegate searchCountryCellPushController:self withSearchDisplayModule:self.displayModuleLeft];
    }
}
@end
