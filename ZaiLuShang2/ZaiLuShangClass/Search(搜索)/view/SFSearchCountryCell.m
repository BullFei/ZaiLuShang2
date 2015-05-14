//
//  SFSearchCountryCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSearchCountryCell.h"
#import "SFSearchDisplayModule.h"
#import "SFImageView.h"
@interface SFSearchCountryCell()
@property (weak, nonatomic) IBOutlet SFImageView *leftImageView;
@property (weak, nonatomic) IBOutlet SFImageView *rightImageView;
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
        [self.leftImageView setImageWithUrl:url  withPlaceHolderImage:nil];
        self.leftTitleLabel.text=displayModuleLeft.name;
    }
}

-(void)setDisplayModuleRight:(SFSearchDisplayModule *)displayModuleRight
{
    if (displayModuleRight) {
        _displayModuleRight = displayModuleRight;
        [self.rightImageView setImageWithUrl:[NSString stringWithFormat:@"%@/f1400/%@",displayModuleRight.picdomain, displayModuleRight.coverpic] withPlaceHolderImage:nil];
        self.rightLabelLabel.text =displayModuleRight.name;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftTitleLabel.center = self.leftImageView.center;
    self.rightLabelLabel.center = self.rightImageView.center;
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
