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
@interface SFTactickCell ()
@property (weak, nonatomic) IBOutlet SFImageView *photoImageView;

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
        
        [self createView];
    }
}


-(void)createView
{
    SFTactick * tactick =[self.searchModel.listArray firstObject];
    UIView * view =[[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:view];
    
    //字体设置
    CGSize titleSize = [TextSizeTools sizeWithString:tactick.title withMaxSize:CGSizeMake(SCREEN_WIDTH, 20) withFont:TextFont_17];
    CGSize subTitleSize = [TextSizeTools sizeWithString:tactick.subtitle withMaxSize:CGSizeMake(SCREEN_WIDTH, 20) withFont:TextFont_15];
    
    CGFloat titleViewW =(titleSize.width>subTitleSize.width?titleSize.width:subTitleSize.width)+10;
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, titleViewW, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text =tactick.title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UIImageView * lineImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, titleViewW, 10)];
    UIImage * image = [UIImage imageNamed:@"bg_pgc_line.9.png"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height * 0.5];
    lineImageView.image = image;
    [view addSubview:lineImageView];
    
    UILabel * subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lineImageView.frame)+5,titleViewW, 20)];
    subTitleLabel.text =tactick.subtitle;
    subTitleLabel.font = [UIFont systemFontOfSize:15];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.textColor = [UIColor whiteColor];
    [view addSubview:subTitleLabel];
    
    if (tactick.logo.length>0) {
        //有logo
        CGFloat logoW =(SCREEN_WIDTH-titleViewW-10)/3*2;
        CGFloat logoH =CGRectGetMaxY(subTitleLabel.frame);
        CGFloat logoX =SCREEN_WIDTH-logoW-10;
        CGFloat logoY =(self.frame.size.height-logoH)/2;
        
        UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(logoX,logoY,logoW,logoH)];
        [logo sd_setImageWithURL:[NSURL URLWithString:tactick.logo]];
        [self addSubview:logo];
        
        view.frame = CGRectMake(logoX-5-titleViewW-10 ,logoY , titleViewW+10, logoH);
    }else{
        view.frame = CGRectMake(0, 0, titleViewW+10, CGRectGetMaxY(subTitleLabel.frame));
        view.center = self.center;    }
    
    

}

@end
