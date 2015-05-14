//
//  MoreThemeCollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreThemeCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface MoreThemeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

    
@end
@implementation MoreThemeCollectionCell
-(void)setMoreThemeModel:(MoreThemeModel *)moreThemeModel
{
    _moreThemeModel =moreThemeModel;
    //梳了个剧
    NSString * contentURL =[NSString stringWithFormat:@"%@f1400/%@",_moreThemeModel.picdomain,_moreThemeModel.coverpic];
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:contentURL]];
    _titleLabel.text =_moreThemeModel.name;
}

+(MoreThemeCollectionCell *)getTripTopicCollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId =@"morethemecollection";
    
    MoreThemeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId forIndexPath:indexPath];
   
//    if (cell ==nil) {
//        UINib * nib =[UINib nibWithNibName:@"morethemecollectioncell" bundle:nil];
//        [collectionView registerNib: nib forCellWithReuseIdentifier:@"morethemecollection"];
//        
//        NSArray * objs =[nib instantiateWithOwner:self options:nil];
//        cell =[objs lastObject];
//    }
    return cell;
    
    
    
    
}

@end
