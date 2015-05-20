//
//  TripTopicCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TripTopicCell.h"
#import "TripTopicCollectionCell.h"
#import "TripTopicModel.h"
@interface TripTopicCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * _collectionView;
}
@end
@implementation TripTopicCell


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
    [layout setMinimumLineSpacing:0];
    
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80*3*SCREEN_WIDTH/320) collectionViewLayout:layout];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    UINib * nib =[UINib nibWithNibName:@"triptopiccollectioncell" bundle:nil];
    [_collectionView registerNib: nib forCellWithReuseIdentifier:@"triptopiccollection"];
    

    [self.contentView addSubview:_collectionView];
    
}
-(void)setTripTopicModelArray:(NSArray *)TripTopicModelArray
{
    _TripTopicModelArray =TripTopicModelArray;
    [_collectionView reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(157*SCREEN_WIDTH/320, 80*SCREEN_WIDTH/320);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   TripTopicCollectionCell * itemCell =[TripTopicCollectionCell getTripTopicCollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    TripTopicModel * mm =[_TripTopicModelArray objectAtIndex:indexPath.row];
    itemCell.tripTopicModel =mm;
    return itemCell;
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

+(TripTopicCell *)getTripTopicCellWithTableView:(UITableView *)tableview
{
    static NSString * cellId =@"triptopic";
    TripTopicCell * cell =[tableview dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell) {
        cell =[[TripTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
