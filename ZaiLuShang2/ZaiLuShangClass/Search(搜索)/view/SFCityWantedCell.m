//
//  SFCityWantedCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFCityWantedCell.h"
#import "SFCityTypeHeadLocality.h"
#import "SFCityTypeHead.h"
#import "UIImageView+WebCache.h"
#import "SFCityTypeHeadTipUser.h"
@interface SFCityWantedCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end

@implementation SFCityWantedCell

+(SFCityWantedCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"wantCell";
    SFCityWantedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFCityWantedCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setCityTypeHead:(SFCityTypeHead *)cityTypeHead
{
    if (cityTypeHead) {
        _cityTypeHead = cityTypeHead;
        SFCityTypeHeadLocality * cityTypeHeadLocality = cityTypeHead.cityTypeHeadLocality;
        self.label.text = [NSString stringWithFormat:@"%d人去过/%d人想去",cityTypeHeadLocality.visitedCnt,cityTypeHeadLocality.wantCnt];
        NSArray  * array =cityTypeHead.tip_users;
        SFCityTypeHeadTipUser * cityTypeHeadTipUser1 = array[0];
        SFCityTypeHeadTipUser * cityTypeHeadTipUser2 = array[1];
        SFCityTypeHeadTipUser * cityTypeHeadTipUser3 = array[2];
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%s/%@",cityTypeHeadTipUser1.picdomain,SMALL_HEAD,cityTypeHeadTipUser1.avatar]]];
        
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%s/%@",cityTypeHeadTipUser1.picdomain,SMALL_HEAD,cityTypeHeadTipUser2.avatar]]];
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%s/%@",cityTypeHeadTipUser1.picdomain,SMALL_HEAD,cityTypeHeadTipUser3.avatar]]];
        
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    CGFloat r =self.imageView1.frame.size.width*0.5;
    self.imageView1.layer.cornerRadius = r;
    self.imageView1.layer.masksToBounds = YES;
    
    self.imageView2.layer.cornerRadius = r;
    self.imageView2.layer.masksToBounds = YES;
    
    self.imageView3.layer.cornerRadius = r;
    self.imageView3.layer.masksToBounds = YES;
}

@end
