//
//  SFSceneryTypeFivtyCell.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSceneryTypeFivtyCell.h"
#import "SFSearchModel.h"
#import "SFSceneryTypeFivtyCollectionViewCell.h"
@interface SFSceneryTypeFivtyCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SFSceneryTypeFivtyCell

+(SFSceneryTypeFivtyCell *)cellWthTableView:(UITableView *)tableView
{
    static NSString *ID  =@"sceneryTypeFivtyCell";
    SFSceneryTypeFivtyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    if(cell==nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SFSceneryTypeFivtyCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setSearchModel:(SFSearchModel *)searchModel
{
    if (searchModel) {
        _searchModel = searchModel;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.scrollEnabled = NO;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-2*6)/3, (SCREEN_WIDTH-2*6)/3);
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
     layout.minimumInteritemSpacing = 3;
    self.collectionView.collectionViewLayout =layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"SFSceneryTypeFivtyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"sceneryTypeFivty"];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchModel.listArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFSceneryTypeFivtyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sceneryTypeFivty" forIndexPath:indexPath];
    NSArray * array = self.searchModel.listArray;
    cell.cityTypeListModel =array[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
