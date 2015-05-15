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
#import "SFUserIconView.h"
#import "SFTourDayVC.h"
#define LEFT_TAG 10
#define RIGHT_TAG 20
@interface SFExctingTourCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet SFUserIconView *leftIconView;
@property (weak, nonatomic) IBOutlet SFUserIconView *rightIconView;
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
        
        [self.leftBgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",leftTour.picdomain,leftTour.coverpic]] placeholderImage:nil];
        
        self.leftLabel.text =leftTour.title;
        
        SFCityTypeHeadTipUser * leftOwner =leftTour.cityTypeHeadTipUser;
        self.leftIconView.user =leftOwner;
        
        SFTour * rightTour = array[1];
        [self.rightBgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",rightTour.picdomain,rightTour.coverpic]] placeholderImage:nil];
        self.rightLabel.text =rightTour.title;
        
        SFCityTypeHeadTipUser * rightOwn  =rightTour.cityTypeHeadTipUser;
        self.rightIconView.user =rightOwn;

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
