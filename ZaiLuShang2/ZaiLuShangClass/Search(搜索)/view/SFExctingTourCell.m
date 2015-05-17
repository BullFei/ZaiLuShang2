//
//  SFExctingTourCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFExctingTourCell.h"
#import "SFSearchModel.h"
#import "SFTour.h"
#import "SFCityTypeHeadTipUser.h"
#import "UIImageView+WebCache.h"
#import "SFTourDayVC.h"
#define LEFT_TAG 10
#define RIGHT_TAG 20
@interface SFExctingTourCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leftIconView;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
@implementation SFExctingTourCell

+(SFExctingTourCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"exctingTourCell";
    SFExctingTourCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFExctingTourCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setSearchModel:(SFSearchModel *)searchModel
{
    if (searchModel) {
        _searchModel = searchModel;
        
        NSArray * array  = _searchModel.listArray;
        SFTour * leftTour = array[0];
        
        [self.leftBgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/b300/%@",leftTour.picdomain,leftTour.coverpic]] placeholderImage:nil];
        
        self.leftLabel.text =leftTour.title;
        
        SFCityTypeHeadTipUser * leftOwner =leftTour.cityTypeHeadTipUser;
        [self.leftIconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ava/%@",leftOwner.picdomain,leftOwner.avatar]] placeholderImage:nil];
        
        SFTour * rightTour = array[1];
        [self.rightBgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/b300/%@",rightTour.picdomain,rightTour.coverpic]] placeholderImage:nil];
        self.rightLabel.text =rightTour.title;
        
        SFCityTypeHeadTipUser * rightOwn  =rightTour.cityTypeHeadTipUser;
        [self.rightIconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ava/%@",rightOwn.picdomain,rightOwn.avatar]] placeholderImage:nil];

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftIconView.layer.cornerRadius = self.leftIconView.frame.size.width*0.5;
    self.leftIconView.layer.masksToBounds = YES;
}

-(void)btnClick:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(exctingTourCell:pushController:)]){
        //游记
        SFTourDayVC * tourDayVC  = [[SFTourDayVC alloc]init];
        tourDayVC.hidesBottomBarWhenPushed = YES;
        
        if (LEFT_TAG==btn.tag) {
            //左边按钮
            tourDayVC.tour =_searchModel.listArray[0];
            
        }else if (RIGHT_TAG==btn.tag){
            //右边按钮
            tourDayVC.tour =_searchModel.listArray[1];
        }
        [self.delegate exctingTourCell:self pushController:tourDayVC];
    
    }
    

}


@end
