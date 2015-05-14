//
//  MoreThemeCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreThemeCell.h"
#import "MoreThemeCollectionCell.h"
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
-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:7];
    
    _collectionView =[[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:layout];
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [MoreThemeCollectionCell getTripTopicCollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
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
