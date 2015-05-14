//
//  SFSceneryCellTableViewCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSceneryCellTableViewCell.h"
#import "SFSearchDisplayModule.h"
#import "UIImageView+WebCache.h"
#import "SFImageView.h"
@interface SFSceneryCellTableViewCell ()
- (IBAction)leftBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *rightBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *leftSubLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftGuideLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightGuideLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTtileLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSubLabel;
@property (weak, nonatomic) IBOutlet SFImageView *leftImageView;
@property (weak, nonatomic) IBOutlet SFImageView *rightImageView;
- (IBAction)rightBtnClcik:(id)sender;

@end

@implementation SFSceneryCellTableViewCell
+(SFSceneryCellTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"sceneryCell";
    SFSceneryCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFSceneryCellTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setDisplayModuleLeft:(SFSearchDisplayModule *)displayModuleLeft
{
    if (displayModuleLeft) {
        _displayModuleLeft = displayModuleLeft;
        NSString * url =[NSString stringWithFormat:@"%@/f1400/%@",
                         displayModuleLeft.picdomain, displayModuleLeft.coverpic];
        //[self.leftImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.leftImageView setImageWithUrl:url  withPlaceHolderImage:nil];
        self.leftTitleLabel.text =displayModuleLeft.name;
        self.leftSubLabel.text =displayModuleLeft.describe;
        if (displayModuleLeft.pgcCnt>0) {
            self.leftGuideLabel.text =[NSString stringWithFormat:@"%d篇指南",displayModuleLeft.pgcCnt];
        }
    }
}

-(void)setDisplayModuleRight:(SFSearchDisplayModule *)displayModuleRight
{
    if (displayModuleRight) {
        _displayModuleRight = displayModuleRight;
        [self.rightImageView setImageWithUrl: [NSString stringWithFormat:@"%@/f1400/%@",displayModuleRight.picdomain, displayModuleRight.coverpic]withPlaceHolderImage:nil];
        self.rightTtileLabel.text =displayModuleRight.name;
        self.rightSubLabel.text =displayModuleRight.describe;
        if (displayModuleRight.pgcCnt>0) {
            self.rightGuideLabel.text =[NSString stringWithFormat:@"%d篇指南",displayModuleRight.pgcCnt];
        }
    }

}

- (IBAction)leftBtnClick:(id)sender {
    if ([self.deleagte respondsToSelector:@selector(sceneryCellTableViewCellPushController:withSearchDisplayModule:)]) {
        [self.deleagte sceneryCellTableViewCellPushController:self withSearchDisplayModule:self.displayModuleLeft];
    }
}


- (IBAction)rightBtnClcik:(id)sender {
    if ([self.deleagte respondsToSelector:@selector(sceneryCellTableViewCellPushController:withSearchDisplayModule:)]) {
        [self.deleagte sceneryCellTableViewCellPushController:self withSearchDisplayModule:self.displayModuleRight];
    }
}
@end
