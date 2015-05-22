//
//  SFUserListCell.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFUserListCell.h"
#import "SFCityTypeHeadTipUser.h"
#import "UIImageView+WebCache.h"
@interface SFUserListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SFUserListCell
+(SFUserListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"userCell";
    SFUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFUserListCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setUser:(SFCityTypeHeadTipUser *)user
{
    if (user) {
        _user = user;
        self.titleLabel.text = user.nickname;
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ava/%@",user.picdomain,user.avatar]]];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width*0.5;
    self.iconView.layer.masksToBounds = YES;
    
}
@end
