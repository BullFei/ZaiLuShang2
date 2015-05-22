//
//  MoreThemeCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreThemeCell.h"
#import "MoreThemeCollectionCell.h"
#import "MoreThemeModel.h"
@interface MoreThemeCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    UICollectionView * _collectionView;
}
@end
@implementation MoreThemeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionView];
    }
    return self;
}
-(void)setMoreThemeModelArray:(NSArray *)moreThemeModelArray
{
    _moreThemeModelArray =moreThemeModelArray;
    [_collectionView reloadData];
}
-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:7];
    
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (80*4+3*7)*SCREEN_WIDTH/320) collectionViewLayout:layout];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor =[UIColor whiteColor];
    UINib * nib =[UINib nibWithNibName:@"morethemecollectioncell" bundle:nil];
    [_collectionView registerNib: nib forCellWithReuseIdentifier:@"morethemecollection"];
    
    [self.contentView addSubview:_collectionView];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(157*SCREEN_WIDTH/320, 80*SCREEN_WIDTH/320);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   MoreThemeCollectionCell * itemCell = [MoreThemeCollectionCell getTripTopicCollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    MoreThemeModel *mm =[_moreThemeModelArray objectAtIndex:indexPath.row];
    itemCell.moreThemeModel =mm;
    return itemCell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //MoreThemeModel *  mm =[_moreThemeModelArray objectAtIndex:indexPath.item];
   // NSNumberFormatter * nf =[[NSNumberFormatter alloc]init];
    
    //self.MoreThemeItemPushBlock([nf stringFromNumber:mm.subjectid]);
}

+(MoreThemeCell *)getMoreThemeCellWithTableView:(UITableView *)tableview
{
    static NSString * cellId =@"moretheme";
    MoreThemeCell * cell =[tableview dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell) {
        cell =[[MoreThemeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
