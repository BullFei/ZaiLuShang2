//
//  MoreThemeCollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreThemeCollectionCell.h"
@interface MoreThemeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

    
@end
@implementation MoreThemeCollectionCell


+(MoreThemeCollectionCell *)getTripTopicCollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId =@"morethemecollection";
    MoreThemeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId forIndexPath:indexPath];
    if (cell ==nil) {
        UINib * nib =[UINib nibWithNibName:@"morethemecollectioncell" bundle:nil];
        [collectionView registerNib: nib forCellWithReuseIdentifier:cellId];
        
        NSArray * objs =[nib instantiateWithOwner:self options:nil];
        cell =[objs lastObject];
    }
    return cell;
    
    
    
    
}

@end
