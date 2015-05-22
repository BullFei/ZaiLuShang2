//
//  Section2CollectionCell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section2ItemModel.h"
@interface Section2CollectionCell : UICollectionViewCell

+(Section2CollectionCell *)getSection2CollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,weak)Section2ItemModel * section2ItemModel;
@property (nonatomic,copy)void(^authorButtonPushBlock)(NSString *,NSInteger page);
@end
