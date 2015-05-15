//
//  SFTourDayCell.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDayCell.h"
#import "UIImageView+WebCache.h"
#import "SFRecord.h"
@interface SFTourDayCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
@implementation SFTourDayCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setRecord:(SFRecord *)record
{
    if (record) {
        _record = record;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/f1400/%@",record.picdomain,record.picfile]] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    }
}


@end
