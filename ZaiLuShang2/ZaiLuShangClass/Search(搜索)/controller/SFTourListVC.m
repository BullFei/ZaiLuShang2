//
//  SFTourListVC.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFTourListVC.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "SFTour.h"
#import "SFCityTypeHeadTipUser.h"
#import "SFTourListCell.h"
#import "SFTourDayVC.h"
#define LENGTH 20
#define PIC_URL @"http://app6.117go.com/demo27/php/discoverAction.php?submit=getLocalityTours&locid=%ld&badge=-1&subtype=-1&length=%ld&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"

#define NOPIC_URL @"http://app6.117go.com/demo27/php/discoverAction.php?submit=getSceneryTours&sceneryid=%ld&badge=-1&subtype=-1&length=%ld&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SFTourListVC ()<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView * header;
    MJRefreshFooterView * footer;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger index;
@end

@implementation SFTourListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createRefreshing];
    [header beginRefreshing];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
#pragma mark -创建nav
-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的游记",self.tag];
}


#pragma mark -想去
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -刷新
-(void)createRefreshing
{
    header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView; // 或者tableView
    header.delegate =self;
    
    //2. 添加尾部控件的方法
    footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView; // 或者tableView
    footer.delegate = self;
}
#pragma mark -刷新代理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if([refreshView isKindOfClass:[MJRefreshHeaderView class]]){
        //头部
        self.index=1;
        [self loadDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"上拉数据请求失败,可能网络慢哦"];
        }];
        
    }else if ([refreshView isKindOfClass:[MJRefreshFooterView class]]){
        //尾部
        self.index+=1;
        [self loadDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"下拉数据请求失败,可能网络慢哦"];
        }];
        
    }
    
    
}

-(void)dealloc
{
    [header free];
    [footer free];
    
}

#pragma mark - 加载数据
-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    if (nil ==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    NSString * url = @"";
    if (self.locid>0) {
       url = [NSString stringWithFormat:PIC_URL,self.locid,LENGTH*self.index];
    }else if (self.sceneryid>0){
        url = [NSString stringWithFormat:NOPIC_URL,self.locid,LENGTH*self.index];
    }
        [RequestTool GET:url parameters:nil success:^(id responseObject) {
        NSArray * array = responseObject[@"obj"][@"list"];
        for (NSInteger i=(self.index-1)*20; i<self.index*20; i++) {
            SFTour * tour = [[SFTour alloc]init];
            [tour setValuesForKeysWithDictionary:array[i]];
            //members
            NSArray * users = array[i][@"members"];
            NSMutableArray * mulUser = [[NSMutableArray alloc]init];
            for (NSDictionary * userDic  in users) {
                SFCityTypeHeadTipUser *cityTypeHeadTipUser = [[SFCityTypeHeadTipUser alloc]init];
                [cityTypeHeadTipUser setValuesForKeysWithDictionary:userDic];
                [mulUser addObject:mulUser];
            }
            tour.memberArray =mulUser;
            
            //owner
            SFCityTypeHeadTipUser * owner = [[SFCityTypeHeadTipUser alloc]init];
            [owner setValuesForKeysWithDictionary:array[i][@"owner"]];
            tour.cityTypeHeadTipUser =owner;

            [_dataArray addObject:tour];
        }
        
        [self.tableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SFTourListCell * cell = [SFTourListCell cellWithTableView:tableView];
        cell.tour = _dataArray[indexPath.row];
        return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH*HUANGJINGSHU*HUANGJINGSHU;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFTourDayVC * tourDayVC = [[SFTourDayVC alloc]init];
    tourDayVC.hidesBottomBarWhenPushed = YES;
    tourDayVC.tour = _dataArray[indexPath.row];
    [self.navigationController pushViewController:tourDayVC animated:YES];
}



@end
