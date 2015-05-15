//
//  SpecialColumnView.m
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SpecialColumnView.h"
@interface SpecialColumnView ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * wordsLabel;
@property (nonatomic,strong)UILabel * leftImageLabel;
@property (nonatomic,strong)UIImageView *rightImageView;
@property (nonatomic,strong)UIControl * ctrl;
@end
    

@implementation SpecialColumnView
-(void)setSpecialColumnModel:(SpecialColumnModel *)specialColumnModel
{
    _specialColumnModel =specialColumnModel;
    _titleLabel.text =_specialColumnModel.title;
    _wordsLabel.text =_specialColumnModel.words;
}
+(SpecialColumnView *)getSpecialColumnViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        _leftImageLabel =[[UILabel alloc]initWithFrame:CGRectMake(8,3 , 5, 24)];
        _leftImageLabel.backgroundColor =[UIColor redColor];
        [self addSubview:_leftImageLabel];
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 3, 100,24 )];
        [self addSubview:_titleLabel];
        _wordsLabel =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, 3, 100, 24)];
        [self addSubview:_wordsLabel];
        _rightImageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 0, 30, 30)];
        _rightImageView.image =[UIImage imageNamed:@"icon_arrows_right"];
        [self addSubview:_rightImageView];
        self.userInteractionEnabled =YES;
        _ctrl =[[UIControl alloc]initWithFrame:self.bounds];
        [_ctrl addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_ctrl];
        
    }
    return self;
}
-(void)controlClick
{
    NSLog(@"~~~~%@",_ctrl);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
