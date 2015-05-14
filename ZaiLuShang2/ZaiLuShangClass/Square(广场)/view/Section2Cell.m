//
//  Section2Cell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Section2Cell.h"
#import "Section2CollectionCell.h"
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
-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:8];
    
    _collectionView =[[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:layout];
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [Section2CollectionCell getSection2CollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
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
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
