//
//  SFTourDayVC.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourDayVC.h"
#import "SFTourDayCell.h"
#import "RequestTool.h"
#import "SFTour.h"
#import "SFTourDay.h"
#import "SFItem.h"
#import "SFCity.h"
#import "NSObject+MJKeyValue.h"
#import "SFTourDayInfo.h"
#import "SFTourDayCustomeModel.h"
#import "SFRecord.h"
#import "SFItinerary.h"
#import "SFTourDayHeaderView.h"
#import "SFTourDayCell.h"
#import "SFTourDayTitleView.h"
#import "CXPhotoVC.h"
#import "CXCollectionVCellModel.h"
#define DAY_URL @"http://app6.117go.com/demo27/php/tourAction.php?submit=getTourItinerary4&tourid=%@&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
#define RECORF_URL @"http://app6.117go.com/demo27/php/formAction.php?submit=getATour2&tourid=%@&ID2=0&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
#define ITEM_INTERVAL INTERVAL_CELL_CELL
#define ITEM_COUNT 3
#define ITEM_WIDTH (CGW(self.view) - (ITEM_COUNT-1)*ITEM_INTERVAL)/ITEM_COUNT
#define ITEM_HEIGHT ITEM_WIDTH
@interface SFTourDayVC ()<UICollectionViewDataSource,UICollectionViewDelegate,SFTourDayHeaderViewDelegate>
{
    UICollectionView * _collectionView;
    SFTourDayHeaderView * headerView;
   
}
@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic) SFTourDay * tourDay;
@property (strong,nonatomic) SFTourDayInfo * tourDayInfo;
@property (strong,nonatomic)NSMutableArray * dataArr;
@end

@implementation SFTourDayVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createCollectionView];
    [self loadData];
   
}

-(SFTourDay *)tourDay
{
    if (nil==_tourDay) {
        _tourDay = [[SFTourDay alloc]init];
    }
    return _tourDay;
}

-(SFTourDayInfo *)tourDayInfo
{
    if (nil==_tourDayInfo) {
        _tourDayInfo = [[SFTourDayInfo alloc]init];
    }
    return _tourDayInfo;
}

-(NSMutableArray *)dataArr
{
    if (nil ==_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

#pragma mark -创建nav
-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}


#pragma mark -返回
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -创建collectionView
-(void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    layout.minimumInteritemSpacing = ITEM_INTERVAL;
    layout.minimumLineSpacing = ITEM_INTERVAL;
    
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"SFTourDayCell" bundle:nil] forCellWithReuseIdentifier:@"tourDayCell"];
    
    //注册头
    [_collectionView registerNib:[UINib nibWithNibName:@"SFTourDayTitleView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:@"headerView"];
}
#pragma mark - 加载数据
-(void)loadData
{
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    [RequestTool GET:[NSString stringWithFormat:DAY_URL,self.tour.id] parameters:nil success:^(id responseObject) {
        
        NSDictionary * dic =responseObject[@"obj"];
        self.tourDay=[SFTourDay objectWithKeyValues:dic];
        
        [RequestTool GET:[NSString stringWithFormat:RECORF_URL,self.tour.id] parameters:nil success:^(id responseObject) {
            self.tourDayInfo = [SFTourDayInfo objectWithKeyValues:responseObject[@"obj"]];
            
            
            NSArray *arr = [CXCollectionVCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"records"]];
            [self.dataArr addObjectsFromArray:arr];

            
            
            [self combineData];
            
            //创建头
            [self createHeaderView];
            
            //刷新
            [_collectionView reloadData];
        } failure:^(NSError *error) {
            CXLog(@"%@",error.localizedDescription);
        }];
        
        
    } failure:^(NSError *error) {
        CXLog(@"%@",error.localizedDescription);
    }];
    
}


-(void)combineData
{
    
    //创建数据源
    if (self.tourDay&&self.tourDayInfo) {
        NSArray * itineraryArray =self.tourDay.itinerary;
        
        for (SFItinerary * itinerary in itineraryArray) {
            SFTourDayCustomeModel * model = [[SFTourDayCustomeModel alloc]init];
            model.itinerary =itinerary;
            [_dataArray addObject:model];
        }
        
        
        NSArray * recoreds =self.tourDayInfo.records;
        for (SFTourDayCustomeModel * model in _dataArray) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            for (SFRecord *recored in recoreds) {
                NSString * recordStr = [recored.timestamp componentsSeparatedByString:@" "][0];
                NSString * itineraryDate =model.itinerary.date;
                if ([recordStr isEqualToString:itineraryDate]) {
                    [array addObject:recored];
                    
                }
            }
            model.tourDayInfoArray =array;
        }
       
    }
}

-(void)createHeaderView
{
    headerView =[SFTourDayHeaderView headerView];
    headerView.tourDayInfo = self.tourDayInfo;
    headerView.delegate =self;
    [_collectionView addSubview:headerView];

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_dataArray[section] tourDayInfoArray]count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFTourDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tourDayCell" forIndexPath:indexPath];
    SFTourDayCustomeModel * model =_dataArray[indexPath.section];
    SFRecord * record =model.tourDayInfoArray[indexPath.row];
    cell.record =record;
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        //头
        SFTourDayTitleView * tourDayTitleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        SFTourDayCustomeModel * model = _dataArray[indexPath.section];;
        tourDayTitleView.itinerary =model.itinerary;
       
         return tourDayTitleView;
    }
    return nil;
}


-(void)tourDayHeaderView:(SFTourDayHeaderView *)view height:(CGFloat)height
{
    _collectionView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    _collectionView.contentOffset = CGPointMake(0, -height-64);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXPhotoVC *vc= [[CXPhotoVC alloc] init];
    vc.dataArr = self.dataArr;
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tourDayHeaderView:(SFTourDayHeaderView *)view pushController:(UIViewController *)controller
{
    [self presentViewController:controller animated:YES completion:nil];
}



@end
