//
//  MoreThemeCollectionCell.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreThemeModel.h"
@interface MoreThemeCollectionCell : UICollectionViewCell
+(MoreThemeCollectionCell *)getTripTopicCollectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,weak)MoreThemeModel * moreThemeModel;
@end
