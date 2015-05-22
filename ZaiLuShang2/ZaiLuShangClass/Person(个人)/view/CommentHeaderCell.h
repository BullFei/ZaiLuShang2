//
//  CommentHeaderCell.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCommentsViewController.h"

@interface CommentHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ig;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *creatAt;


- (void)configUIWithController:(LYCommentsViewController *)controller;
@end
