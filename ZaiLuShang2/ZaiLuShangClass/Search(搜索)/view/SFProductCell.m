//
//  SFProductCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFProductCell.h"
#import "SFSearchModel.h"
#import "SFProduct.h"
#import "UIImageView+WebCache.h"
#import "AttributedLabel.h"
#import "SFNormalWebViewVC.h"
@interface SFProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDesLabel;
@property (weak, nonatomic) IBOutlet AttributedLabel *leftPriceLabel;
@property (weak, nonatomic) IBOutlet AttributedLabel *rightPriceLabel;
- (IBAction)leftBtnClick:(id)sender;
- (IBAction)rightBtnClick:(id)sender;

@end

@implementation SFProductCell

+(SFProductCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"productCell";
    SFProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFProductCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setSearchModel:(SFSearchModel *)searchModel
{
    if (searchModel) {
        _searchModel =searchModel;
        NSArray * array =searchModel.listArray;
        
        SFProduct * productLeft =array[0];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/b300/%@",productLeft.picdomain,productLeft.picurl]] placeholderImage:nil];
        self.leftDesLabel.text =productLeft.name;
        NSString * leftPrice =[NSString stringWithFormat:@"￥%@起",productLeft.priceNow];
        self.leftPriceLabel.text =leftPrice;
        NSRange range =[leftPrice rangeOfString:@"起"];
        [self.leftPriceLabel setColor:[UIColor orangeColor] fromIndex:0 length:range.location+1];
        [self.leftPriceLabel setFont:[UIFont systemFontOfSize:17] fromIndex:0 length:range.location+1];

        SFProduct * productRight =array[1];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/b300/%@",productRight.picdomain,productRight.picurl]] placeholderImage:nil];
        self.rightDesLabel.text =productRight.name;
        NSString * rightPrice =[NSString stringWithFormat:@"￥%@起",productRight.priceNow];
        self.rightPriceLabel.text =rightPrice;
        NSRange range2 =[leftPrice rangeOfString:@"起"];
        [self.rightPriceLabel setColor:[UIColor orangeColor] fromIndex:0 length:range2.location+1];
        [self.rightPriceLabel setFont:[UIFont systemFontOfSize:17] fromIndex:0 length:range2.location+1];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat h =(self.leftImageView.frame.size.width*0.5-3)*HUANGJINGSHU*HUANGJINGSHU;
    self.leftImageView.frame = CGRectMake(self.leftImageView.frame.origin.x, self.leftImageView.frame.origin.y, self.leftImageView.frame.size.width*0.5-3, h);
    self.rightImageView.frame =CGRectMake(self.rightImageView.frame.origin.x, self.rightImageView.frame.origin.y, self.rightImageView.frame.size.width*0.5-3, h);

}
- (IBAction)leftBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(productCell:pushController:)]) {
        SFNormalWebViewVC *vc = [[SFNormalWebViewVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.message = @"商品详情";
        SFProduct * product = self.searchModel.listArray[0];
        vc.url = product.link;
        [self.delegate productCell:self pushController:vc];
    }
}

- (IBAction)rightBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(productCell:pushController:)]) {
        SFNormalWebViewVC *vc = [[SFNormalWebViewVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.message = @"商品详情";
        SFProduct * product = self.searchModel.listArray[1];
        vc.url = product.link;
        [self.delegate productCell:self pushController:vc];
    }

}
@end
