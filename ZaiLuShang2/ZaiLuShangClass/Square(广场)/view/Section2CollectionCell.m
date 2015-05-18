//
//  Section2CollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Section2CollectionCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@interface Section2CollectionCell()
@property (weak, nonatomic) IBOutlet UIButton *authorButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation Section2CollectionCell
+(Section2CollectionCell *)getSection2CollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId =@"section2collection";
    
    Section2CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId forIndexPath:indexPath];
//    if (cell ==nil) {
//        UINib * nib =[UINib nibWithNibName:@"section2collectioncell" bundle:nil];
//        [collectionView registerNib: nib forCellWithReuseIdentifier:cellId];
//        
//        NSArray * objs =[nib instantiateWithOwner:self options:nil];
//        cell =[objs lastObject];
//    }
    return cell;
    
    
    
    
}
-(void)setSection2ItemModel:(Section2ItemModel *)section2ItemModel
{
    _section2ItemModel =section2ItemModel;
    //数据加载
    NSString * contentURL =[NSString stringWithFormat:@"%@f1400/%@",_section2ItemModel.picdomain,_section2ItemModel.coverpic];
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:contentURL]];
    _titleLabel.text =_section2ItemModel.title;
    //作者button
    NSString * str =[NSString stringWithFormat:@"%@%@%@",_section2ItemModel.owner.picdomain,BIG_HEAD,_section2ItemModel.owner.avatar];
    _authorButton.layer.cornerRadius =_authorButton.frame.size.width/2;
    _authorButton.layer.masksToBounds =YES;

    [_authorButton sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
    
}
@end






