//
//  SFTitleCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTitleCell.h"
#import "SFSearchModel.h"
#import "SFLinkTitleList.h"

@interface SFTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation SFTitleCell

+(SFTitleCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID  =@"titleCell";
    SFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFTitleCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setSearchModel:(SFSearchModel *)searchModel
{
    if (searchModel) {
        _searchModel = searchModel;
        SFLinkTitleList * titleList =[searchModel.listArray firstObject];
        
        self.titleLabel.text =titleList.title;
        
        self.rightLabel.text =titleList.words;
    }
}

@end
