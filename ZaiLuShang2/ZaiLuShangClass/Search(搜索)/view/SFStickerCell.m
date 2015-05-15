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

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


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
        [self createLeftViewSecenry];
        [self createRightViewSecenry];
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
    if (cityTypeHeadLocality.stickerCnt==0) {
        self.leftLabel.text =@"暂无贴士";
    }else{
        self.leftLabel.text = [NSString stringWithFormat:@"%ld条贴士",cityTypeHeadLocality.stickerCnt];
    }

}

-(void)createRightView
{
    SFCityTypeHeadLocality * cityTypeHeadLocality =self.cityTypeHead.cityTypeHeadLocality;
   
    if (cityTypeHeadLocality.tourCnt==0) {
        self.rightLabel.text =@"暂无游记";
    }else{
        self.rightLabel.text = [NSString stringWithFormat:@"%ld篇游记",cityTypeHeadLocality.tourCnt];
    }

}


-(void)createLeftViewSecenry
{
    SFCityTypeListModel * cityTypeListModel =self.sceneryObjModel.scenery;
    if (cityTypeListModel.stickerCnt==0) {
        self.leftLabel.text =@"暂无贴士";
    }else{
        self.leftLabel.text = [NSString stringWithFormat:@"%ld条贴士",cityTypeListModel.stickerCnt];
    }
    
}

-(void)createRightViewSecenry
{
    SFCityTypeListModel * cityTypeListModel =self.sceneryObjModel.scenery;
    
    if (cityTypeListModel.tourCnt==0) {
        self.rightLabel.text =@"暂无游记";
    }else{
        self.rightLabel.text = [NSString stringWithFormat:@"%ld篇游记",cityTypeListModel.tourCnt];
    }
}



-(void)leftBtnClick
{
    
}

-(void)rightBtnClick
{
    //游记
    
    if ([self.delegate respondsToSelector:@selector(stickerCell:withID:withSign:)]) {
        if (self.cityTypeHead&&self.cityTypeHead.cityTypeHeadLocality.tourCnt>0) {
            [self.delegate stickerCell:self withID:self.cityTypeHead.cityTypeHeadLocality.id withSign:@"tour"];
        }else if (self.sceneryObjModel&&self.sceneryObjModel.scenery.tourCnt>0){
            [self.delegate stickerCell:self withID:self.sceneryObjModel.scenery.id withSign:@"tour"];
            
        }
        
    }
}
@end
