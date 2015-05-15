//
//  SFTourListCell.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourListCell.h"
#import "SFTour.h"
#import "UIImageView+WebCache.h"
#import "SFCityTypeHeadTipUser.h"
@interface SFTourListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *LabelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImagView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eyeLabel;
@property (weak, nonatomic) IBOutlet UILabel *picNumLabel;

@end


@implementation SFTourListCell

+(SFTourListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"tourListCell";
    SFTourListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFTourListCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setTour:(SFTour *)tour
{
    if (tour) {
        _tour = tour;
        self.titleLabel.text =tour.title;
        SFCityTypeHeadTipUser * user =tour.cityTypeHeadTipUser;
        [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ava/%@",user.picdomain,user.avatar]] placeholderImage:nil];
        
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",tour.picdomain,tour.coverpic]] placeholderImage:nil];
        
        self.picNumLabel.text = tour.cntP;
        if ([tour.cntFav integerValue]/1000>0) {
            self.eyeLabel.text = [NSString stringWithFormat:@"%ldk",[tour.cntFav integerValue]/1000];
        }else{
            self.likeLabel.text = tour.cntFav;
        }
        
        
        
        if ([tour.viewCnt integerValue]/1000>0) {
            self.eyeLabel.text = [NSString stringWithFormat:@"%ldk",[tour.viewCnt integerValue]/1000];
        }else{
            self.eyeLabel.text =tour.viewCnt;
        }
    }
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    CGRect frame = self.frame;
    frame.size.height = frame.size.width*HUANGJINGSHU*HUANGJINGSHU;
    self.frame =frame;
}
@end
