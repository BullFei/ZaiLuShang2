//
//  TripTopicCollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TripTopicCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface TripTopicCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *discussLabel;

@end
@implementation TripTopicCollectionCell

-(void)setTripTopicModel:(TripTopicModel *)tripTopicModel
{
    _tripTopicModel =tripTopicModel;
    //数据佳佳
    NSString * leftPic =[NSString stringWithFormat:@"%@b300/%@",_tripTopicModel.picdomain,_tripTopicModel.coverpic];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftPic]];
    _titleLabel.text =_tripTopicModel.name;
    NSNumberFormatter * nf =[[NSNumberFormatter alloc]init];
    _discussLabel.text =[NSString stringWithFormat:@"%@ 讨论",[nf stringFromNumber:_tripTopicModel.stickercnt]];
    
}
+(TripTopicCollectionCell *)getTripTopicCollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId =@"triptopiccollection";
    TripTopicCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId forIndexPath:indexPath];
//    if (cell ==nil) {
//        UINib * nib =[UINib nibWithNibName:@"triptopiccollectioncell" bundle:nil];
//        [collectionView registerNib: nib forCellWithReuseIdentifier:@"triptopiccollection"];
//        
//        NSArray * objs =[nib instantiateWithOwner:self options:nil];
//        cell =[objs lastObject];
//    }
    return cell;
    
    
    
    
}

@end
