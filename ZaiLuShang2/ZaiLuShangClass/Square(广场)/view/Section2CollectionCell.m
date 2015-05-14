//
//  Section2CollectionCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Section2CollectionCell.h"
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
    if (cell ==nil) {
        UINib * nib =[UINib nibWithNibName:@"section2collectioncell" bundle:nil];
        [collectionView registerNib: nib forCellWithReuseIdentifier:cellId];
        
        NSArray * objs =[nib instantiateWithOwner:self options:nil];
        cell =[objs lastObject];
    }
    return cell;
    
    
    
    
}
@end
