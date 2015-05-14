//
//  SFStickerCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFStickerCell.h"
#import "SFCityTypeHeadLocality.h"
#import "SFCityTypeHead.h"
#import "SFCityTypeListModel.h"
#import "SFSceneryObjModel.h"
@interface SFStickerCell()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end
@implementation SFStickerCell

+(SFStickerCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"stickerCell";
    SFStickerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFStickerCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setCityTypeHead:(SFCityTypeHead *)cityTypeHead
{
    if (cityTypeHead) {
        _cityTypeHead = cityTypeHead;
        [self createLeftView];
        [self createRightView];
    }
}

-(void)setSceneryObjModel:(SFSceneryObjModel *)sceneryObjModel
{
    if (sceneryObjModel) {
        _sceneryObjModel =sceneryObjModel;
    }
}

-(void)layoutSubviews
{
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [super layoutSubviews];
}

-(void)createLeftView
{
    SFCityTypeHeadLocality * cityTypeHeadLocality =self.cityTypeHead.cityTypeHeadLocality;
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectZero];
    UIImageView * leftIconView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 7, 15, 15)];
    leftIconView.image = [UIImage imageNamed:@"icon_destination_tips_32"];
    [leftView addSubview:leftIconView];
    
    
    NSString * stickerStr = [NSString stringWithFormat:@"%d",cityTypeHeadLocality.stickerCnt];
    CGSize numSize = [TextSizeTools sizeWithString:stickerStr withMaxSize:CGSizeMake(100, 30) withFont:TextFont_17];
    UILabel * leftNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftIconView.frame)+6, 0, numSize.width, 30)];
    [leftView addSubview:leftNumLabel];
    leftNumLabel.text =stickerStr;
    leftNumLabel.font = TextFont_17;
    leftNumLabel.textColor = [UIColor blueColor];
    
    
    CGSize labelSize = [TextSizeTools sizeWithString:@"条贴士" withMaxSize:CGSizeMake(100, 30) withFont:TextFont_15];
    UILabel * leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftNumLabel.frame)+6, 5, labelSize.width, 20)];
    [leftView addSubview:leftLabel];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.text =@"条贴士";
    leftLabel.font =[UIFont systemFontOfSize:15];
    leftView.frame = CGRectMake(0, 0, CGRectGetMaxX(leftLabel.frame), 30);
    [self.leftBtn addSubview:leftView];
    leftView.center = self.leftBtn.center;

}

-(void)createRightView
{
    SFCityTypeHeadLocality * cityTypeHeadLocality =self.cityTypeHead.cityTypeHeadLocality;
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:rightView];
    UIImageView * rightIconView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 7, 15, 15)];
    rightIconView.image = [UIImage imageNamed:@"icon_destination_trip_32"];
    [rightView addSubview:rightIconView];
    
   
    NSString * tourStr = [NSString stringWithFormat:@"%d",cityTypeHeadLocality.tourCnt];
    CGSize numSize = [TextSizeTools sizeWithString:tourStr withMaxSize:CGSizeMake(100, 30) withFont:TextFont_17];
    UILabel * rightNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightIconView.frame)+6, 0, numSize.width, 30)];
    [rightView addSubview:rightNumLabel];
    rightNumLabel.text =tourStr;
    rightNumLabel.font = [UIFont systemFontOfSize:17];
    rightNumLabel.textColor = [UIColor blueColor];
    
    
    CGSize labelSize = [TextSizeTools sizeWithString:@"篇游记" withMaxSize:CGSizeMake(100, 30) withFont:TextFont_15];
    UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightNumLabel.frame)+6, 5, labelSize.width, 20)];
    [rightView addSubview:rightLabel];
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.text =@"篇游记";
    rightLabel.font =[UIFont systemFontOfSize:15];
    
    rightView.frame = CGRectMake(0, 0, CGRectGetMaxX(rightLabel.frame), 30);
    NSLog(@"%@",NSStringFromCGPoint(self.rightBtn.center));
    rightView.center  =self.rightBtn.center;
}


-(void)createLeftViewSecenry
{
    SFCityTypeListModel * cityTypeListModel =self.sceneryObjModel.scenery;
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectZero];
    UIImageView * leftIconView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 7, 15, 15)];
    leftIconView.image = [UIImage imageNamed:@"icon_destination_tips_32"];
    [leftView addSubview:leftIconView];
    
    
    NSString * stickerStr = [NSString stringWithFormat:@"%d",cityTypeListModel.stickerCnt];
    CGSize numSize = [TextSizeTools sizeWithString:stickerStr withMaxSize:CGSizeMake(100, 30) withFont:TextFont_17];
    UILabel * leftNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftIconView.frame)+6, 0, numSize.width, 30)];
    [leftView addSubview:leftNumLabel];
    leftNumLabel.text =stickerStr;
    leftNumLabel.font = TextFont_17;
    leftNumLabel.textColor = [UIColor blueColor];
    
    
    CGSize labelSize = [TextSizeTools sizeWithString:@"条贴士" withMaxSize:CGSizeMake(100, 30) withFont:TextFont_15];
    UILabel * leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftNumLabel.frame)+6, 5, labelSize.width, 20)];
    [leftView addSubview:leftLabel];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.text =@"条贴士";
    leftLabel.font =[UIFont systemFontOfSize:15];
    leftView.frame = CGRectMake(0, 0, CGRectGetMaxX(leftLabel.frame), 30);
    [self.leftBtn addSubview:leftView];
    leftView.center = self.leftBtn.center;
    
}

-(void)createRightViewSecenry
{
    SFCityTypeListModel * cityTypeListModel =self.sceneryObjModel.scenery;
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:rightView];
    UIImageView * rightIconView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 7, 15, 15)];
    rightIconView.image = [UIImage imageNamed:@"icon_destination_trip_32"];
    [rightView addSubview:rightIconView];
    
    
    NSString * tourStr = [NSString stringWithFormat:@"%d",cityTypeListModel.tourCnt];
    CGSize numSize = [TextSizeTools sizeWithString:tourStr withMaxSize:CGSizeMake(100, 30) withFont:TextFont_17];
    UILabel * rightNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightIconView.frame)+6, 0, numSize.width, 30)];
    [rightView addSubview:rightNumLabel];
    rightNumLabel.text =tourStr;
    rightNumLabel.font = [UIFont systemFontOfSize:17];
    rightNumLabel.textColor = [UIColor colorWithRed:97/255.0 green:184/255.0 blue:224/255.0 alpha:1];
    
    
    CGSize labelSize = [TextSizeTools sizeWithString:@"篇游记" withMaxSize:CGSizeMake(100, 30) withFont:TextFont_15];
    UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightNumLabel.frame)+6, 5, labelSize.width, 20)];
    [rightView addSubview:rightLabel];
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.text =@"篇游记";
    rightLabel.font =[UIFont systemFontOfSize:15];
    
    rightView.frame = CGRectMake(0, 0, CGRectGetMaxX(rightLabel.frame), 30);
    NSLog(@"%@",NSStringFromCGPoint(self.rightBtn.center));
    rightView.center  =self.rightBtn.center;
}



-(void)leftBtnClick
{

}

-(void)rightBtnClick
{

}
@end
