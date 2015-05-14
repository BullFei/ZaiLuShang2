//
//  TripTopicCollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TripTopicCollectionCell.h"
@interface TripTopicCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *discussLabel;

@end
@implementation TripTopicCollectionCell


+(TripTopicCollectionCell *)getTripTopicCollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId =@"triptopiccollection";
    TripTopicCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId forIndexPath:indexPath];
    if (cell ==nil) {
        UINib * nib =[UINib nibWithNibName:@"triptopiccollectioncell" bundle:nil];
        [collectionView registerNib: nib forCellWithReuseIdentifier:cellId];
        
        NSArray * objs =[nib instantiateWithOwner:self options:nil];
        cell =[objs lastObject];
    }
    return cell;
    
    
    
    
}

@end
