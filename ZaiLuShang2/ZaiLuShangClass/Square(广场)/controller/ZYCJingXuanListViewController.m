//
//  ZYCJingXuanListViewController.m
//  ZaiLuShang2
//
//  Created by qianfengLQL on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCJingXuanListViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "Header.h"
#import "MJExtension.h"

//#import "JingXuanCell.h"
//#import "JingXuanModel.h"
#import "SFTourListCell.h"
#import "SFTour.h"
#import "SFTourDayVC.h"
#define ZYC_GROUND_JINGXUANLIST_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=getPlazaTours&length=%ld&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0" //参数length

@interface ZYCJingXuanListViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView * header;
    MJRefreshFooterView * footer;
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger length;
@end

@implementation ZYCJingXuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self initDataArray];
    
    [self createNav];
    [self createTableView];
    [self createRefreshing];
    [header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [header free];
    [footer free];
    
}

#pragma mark -创建nav
-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    self.navigationItem.title = @"每日精选";
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark 创建UITableView
-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGW(self.view),CGH(self.view)-64 ) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma  mark 刷新
-(void)createRefreshing
{
    header = [MJRefreshHeaderView header];
    header.scrollView = _tableView; // 或者tableView
    header.delegate =self;
    
    //2. 添加尾部控件的方法
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView; // 或者tableView
    footer.delegate = self;
}
#pragma  mark 刷新代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    [_dataArray removeAllObjects];
    if([refreshView isKindOfClass:[MJRefreshHeaderView class]]){
        //头部
        
        self.length=10;
        [self loadDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"上拉数据请求失败,可能网络慢哦"];
        }];
        
    }else if ([refreshView isKindOfClass:[MJRefreshFooterView class]]){
        //尾部
        self.length+=10;
        [self loadDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"下拉数据请求失败,可能网络慢哦"];
        }];
        
    }
    
    
}
#pragma  mark 数据部分
-(void)initDataArray
{
    if (nil ==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
}
-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    
    NSString * url =[NSString stringWithFormat:ZYC_GROUND_JINGXUANLIST_URL, self.length];
    [RequestTool GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        for (NSDictionary * dd in array) {
            NSArray * tmpArray =dd[@"list"];
            NSArray * modelArray =[SFTour objectArrayWithKeyValuesArray:tmpArray];
            [_dataArray addObjectsFromArray:modelArray];
        }
        
        [_tableView reloadData];
        if (success) {
            success();
            
        }
        
        
    } failure:^(NSError *error) {
        CXLog(@"%@",error.localizedDescription);
        if (failure) {
            failure();
        }
    }];
}
#pragma  mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  SCREEN_WIDTH*HUANGJINGSHU*HUANGJINGSHU;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFTourListCell * cell = [SFTourListCell cellWithTableView:tableView];
    cell.tour = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFTourDayVC * tourDayVC = [[SFTourDayVC alloc]init];
    tourDayVC.hidesBottomBarWhenPushed = YES;
    tourDayVC.tour = _dataArray[indexPath.row];
    [self.navigationController pushViewController:tourDayVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
