//
//  JingXuanCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JingXuanCell.h"


@interface  JingXuanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;


@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;

@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *pictureCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *tuLabel;

@property (weak, nonatomic) IBOutlet UIButton *authorButton;

@property (weak, nonatomic) IBOutlet UIScrollView *commentsScrollView;

@end
@implementation JingXuanCell


+(JingXuanCell *)GetJingXuanCellWithTableView:(UITableView *)tableview
{
    static NSString * cellId =@"jingxuan";
    JingXuanCell * cell =[tableview dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        UINib *nib =[UINib nibWithNibName:@"jingxuancell" bundle:nil];
        [tableview registerNib:nib forCellReuseIdentifier:cellId];
        NSArray * objs=[nib instantiateWithOwner:self options:nil];
        cell =objs.lastObject;
    }
    return cell;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
