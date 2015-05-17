//
//  Section2Cell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Section2Cell.h"
#import "Section2CollectionCell.h"
#import "Section2ItemModel.h"
@interface Section2Cell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView  * _collectionView;

}
@end
@implementation Section2Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionView];
    }
    return self;
}
-(void)setSection2ItemModelArray:(NSArray *)Section2ItemModelArray
{
    _Section2ItemModelArray =Section2ItemModelArray;
    [_collectionView reloadData];
}
-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:8];
    
   
    //CGRectMake(0, 0, 375, 88*2+8)
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 88*2+8) collectionViewLayout:layout];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor =[UIColor whiteColor];
    UINib * nib =[UINib nibWithNibName:@"section2collectioncell" bundle:nil];
    [_collectionView registerNib: nib forCellWithReuseIdentifier:@"section2collection"];

    [self.contentView addSubview:_collectionView];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(183, 88);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     Section2CollectionCell * itemCell = [Section2CollectionCell getSection2CollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    Section2ItemModel * mm =[_Section2ItemModelArray objectAtIndex:indexPath.row];
    itemCell.section2ItemModel =mm;
    return itemCell;
    
    
}



+(Section2Cell *)getSection2ViewWithTableView:(UITableView *)tableview
{
    static NSString * cellId =@"section2";
    Section2Cell * cell =[tableview dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell) {
        cell =[[Section2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

@end
