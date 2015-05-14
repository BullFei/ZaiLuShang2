//
//  SFTactickCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTactickCell.h"
#import "SFSearchModel.h"
#import "SFTactick.h"
#import "UIImageView+WebCache.h"
#import "SFImageView.h"
@interface SFTactickCell ()
@property (weak, nonatomic) IBOutlet SFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;


@end

@implementation SFTactickCell

+(SFTactickCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"tactickCell";
    SFTactickCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFTactickCell" owner:nil options:nil]lastObject];
        
    }
    return cell;
}

-(void)setSearchModel:(SFSearchModel *)searchModel
{
    if (searchModel) {
        _searchModel = searchModel;
        SFTactick * tactick =[searchModel.listArray firstObject];
        [self.photoImageView setImageWithUrl:tactick.banner.img_xxlarge_high  withPlaceHolderImage:nil];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    SFTactick * tactick =[self.searchModel.listArray firstObject];

    //字体设置
    CGSize titleSize = [TextSizeTools sizeWithString:tactick.title withMaxSize:CGSizeMake(SCREEN_WIDTH, 20) withFont:TextFont_17];
    CGSize subTitleSize = [TextSizeTools sizeWithString:tactick.subtitle withMaxSize:CGSizeMake(SCREEN_WIDTH, 20) withFont:TextFont_15];
    
    CGFloat titleViewW =(titleSize.width>subTitleSize.width?titleSize.width:subTitleSize.width)+10;
    
    self.titleLabel.text =tactick.title;
    self.titleLabel.frame = CGRectMake(0, 0,titleViewW , 20);
    
    self.lineImageView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), titleViewW, 2);
    self.lineImageView.image = [UIImage imageNamed:@""];
    
    
    self.subTitleLabel.text =tactick.subtitle;
    self.subTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.lineImageView.frame), titleViewW, 20);
    
    self.titleView.frame = CGRectMake(0, 0, titleViewW, CGRectGetMaxY(self.subTitleLabel.frame));
    self.titleView.center = self.center;

}

@end
