//
//  SFUserIconView.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFUserIconView.h"
#import "SFCityTypeHeadTipUser.h"
#import "UIImageView+WebCache.h"
@interface SFUserIconView(){
    UIImageView * imageView;
    UIImageView * starView;
}

@end
@implementation SFUserIconView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setUser:(SFCityTypeHeadTipUser *)user
{
    if (user) {
        _user = user;
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4*3, self.frame.size.height/4*3)];
        [self addSubview:imageView];
        imageView.layer.cornerRadius =imageView.frame.size.width*0.5;
        imageView.layer.masksToBounds = YES;
        
        starView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-10, self.frame.size.height*0.5-10, self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:starView];

        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%s/%@",user.picdomain,BIG_HEAD,user.avatar]] placeholderImage:nil];
        starView.image = [UIImage imageNamed:@"badge_traveler_v1_36"];
        
        iconBtn = [[UIButton alloc]initWithFrame:self.frame];
        [self addSubview:iconBtn];
        
    }
}
@end
