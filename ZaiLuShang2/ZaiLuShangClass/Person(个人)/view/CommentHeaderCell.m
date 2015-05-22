//
//  CommentHeaderCell.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentHeaderCell.h"
#import "UIImageView+WebCache.h"

@implementation CommentHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUIWithController:(LYCommentsViewController *)controller {
    [self.ig sd_setImageWithURL:[NSURL URLWithString:controller.iconURL] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
    self.content.text = controller.headTitle;
    self.content.numberOfLines = 0;
    
    self.creatAt.text = controller.createAt;
}
@end
