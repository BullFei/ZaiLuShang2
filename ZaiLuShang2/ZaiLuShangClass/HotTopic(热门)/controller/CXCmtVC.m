//
//  CXCmtVC.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXCmtVC.h"
#import "RequestTool.h"
#import "CXCollectionVCell.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CXCmtModel.h"
#import "CXCmtCell.h"
#import "CXCmtFrameModel.h"


@interface CXCmtVC () <UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,weak) MJRefreshHeaderView *header;
@property (nonatomic ,weak) MJRefreshFooterView *footer;

@property (nonatomic ,copy) NSString *url;

@property (nonatomic ,weak) UITableView *tableView;
@end

@implementation CXCmtVC


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
    
    [self createUI];
    
    [self.header beginRefreshing];
}

- (void)setModel:(CXCollectionVCellModel *)model
{
    _model = model;
    self.url = [NSString stringWithFormat:@"http://app6.117go.com/demo27/php/formAction.php?submit=getCmt&onitemtype=1&onitemid=%@&length=20&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0", model.picid];
}

// 数据请求
- (void)requestDataSuccess:(void (^)(id responseObject))success failure:(void (^)())failure
{
    
    [RequestTool GET:self.url parameters:nil success:^(id responseObject) {
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
- (void)createUI
{
    
    UITableView *view = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor whiteColor];
    self.tableView = view;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = view;
    header.delegate = self;
    self.header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = view;
    footer.delegate = self;
    self.footer = footer;
    
}

- (void)dealloc
{
    [self.footer free];
    [self.header free];
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
        
        NSArray *arr = [CXCmtModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"list"]];
//        for (int i = arr.count-1; i >= 0 ; i--) {
//            [self.dataArr insertObject:arr[i] atIndex:0];
//        }
        NSMutableArray *arrM = [NSMutableArray array];
        for (CXCmtModel *model in arr) {
            CXCmtFrameModel *frameModel = [[CXCmtFrameModel alloc] init];
            frameModel.cmtModel = model;
            [arrM addObject:frameModel];
        }
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:arrM];
        
        [self.tableView reloadData];
        
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
        
        NSArray *arr = [CXCmtModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"list"]];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (CXCmtModel *model in arr) {
            CXCmtFrameModel *frameModel = [[CXCmtFrameModel alloc] init];
            frameModel.cmtModel = model;
            [arrM addObject:frameModel];
        }
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:arrM];
        
        [self.tableView reloadData];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXCmtCell *cell =  [CXCmtCell cmtCellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXCmtFrameModel *frameModel = self.dataArr[indexPath.row];
    return frameModel.cellH;
}

@end
