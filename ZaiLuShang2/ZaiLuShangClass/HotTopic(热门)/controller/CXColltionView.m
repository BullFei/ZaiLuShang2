//
//  CXColltionView.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXColltionView.h"


#define ITEM_INTERVAL INTERVAL_CELL_CELL
#define ITEM_COUNT 3
#define ITEM_WIDTH (CGW(self.view) - (ITEM_COUNT-1)*ITEM_INTERVAL)/ITEM_COUNT
#define ITEM_HEIGHT ITEM_WIDTH

@interface CXColltionView () <UICollectionViewDelegate, UICollectionViewDataSource, MJRefreshBaseViewDelegate>



@end

@implementation CXColltionView
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
    
    // 开始刷新
    [self.header beginRefreshing];
}

- (void)setUrl:(NSString *)url
{
    _url = url;
}

- (void)setOtherUrl:(NSString *)otherUrl
{
    _otherUrl = otherUrl;
}

// 数据请求
- (void)requestDataSuccess:(void (^)(id responseObject))success failure:(void (^)())failure
{
    
    [RequestTool GET:(self.url.length == 0 ? self.otherUrl : self.url) parameters:nil success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        CXLog(@"%@", error);
        if (failure) {
            failure();
        }
    }];
}

// 创建collectionView
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    layout.minimumInteritemSpacing = ITEM_INTERVAL;
    layout.minimumLineSpacing = ITEM_INTERVAL;
    
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:view];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor whiteColor];
    self.collectionView = view;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = view;
    header.delegate = self;
    self.header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = view;
    footer.delegate = self;
    self.footer = footer;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CXCollectionVCell" bundle:nil] forCellWithReuseIdentifier:@"CXCollectionVCell"];
}
// 开始刷新
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self refreshHeaderViewSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"下拉数据请求失败,可能网络慢哦"];
        }];
    } else if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self refreshFooterViewSuccess:^{
             [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"上拉数据请求失败,可能网络慢哦"];
        }];
    }
}
// 刷新header
- (void)refreshHeaderViewSuccess:(void (^)())success failure:(void (^)())failure
{
    [self requestDataSuccess:^(id responseObject) {
        
        if (self.url.length > 0) {
            NSArray *arr = [CXCollectViewCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"]];
            for (int i = arr.count-1; i >= 0 ; i--) {
                [self.dataArr insertObject:arr[i] atIndex:0];
            }
        } else if (self.otherUrl.length > 0) {
            NSArray *arr = [CXCollectionVCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"list"]];
            for (int i = arr.count-1; i >= 0 ; i--) {
                [self.dataArr insertObject:arr[i] atIndex:0];
            }
        }
        
        [self.collectionView reloadData];
        
        if (success) {
            success();
        }
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}
// 刷新footer
- (void)refreshFooterViewSuccess:(void (^)())success failure:(void (^)())failure
{
    [self requestDataSuccess:^(id responseObject) {
        if (self.url.length > 0) {
            NSArray *arr = [CXCollectViewCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"]];
            [self.dataArr addObjectsFromArray:arr];
        } else if (self.otherUrl.length > 0) {
            NSArray *arr = [CXCollectionVCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"list"]];
            [self.dataArr addObjectsFromArray:arr];
        }
       
        
        [self.collectionView reloadData];
        
        if (success) {
            success();
        }
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXCollectionVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXCollectionVCell" forIndexPath:indexPath];
    
    if ([[self.dataArr firstObject] isKindOfClass:[CXCollectViewCellModel class]]) {
        CXCollectViewCellModel *model = self.dataArr[indexPath.row];
        cell.model = model.pic;
    } else if ([[self.dataArr firstObject] isKindOfClass:[CXCollectionVCellModel class]]) {
        cell.model = self.dataArr[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 代理
// 点击选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXPhotoVC *vc= [[CXPhotoVC alloc] init];
    vc.dataArr = self.dataArr;
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    [self.footer free];
    [self.header free];
}

@end
