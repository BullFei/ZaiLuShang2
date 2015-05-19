//
//  ZYCSubjectListViewController.m
//  ZaiLuShang2
//
//  Created by qianfengLQL on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCSubjectListViewController.h"

#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "Header.h"
#import "MJExtension.h"


#import "SubjectHeadModel.h"
#import "SFTour.h"
#import "UIImageView+WebCache.h"
#define ZYC_GROUND_HEAD_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=subjectHome&subjectid=%@&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0" //参数subjectid
#define ZYC_GROUND_TOURLIST_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=subjectTours&subjectid=%@&length=%ld&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0"//参数subjectid 和length
@interface ZYCSubjectListViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UIScrollViewDelegate>
{
    //MJRefreshHeaderView * header;
    MJRefreshFooterView * footer;
    UIImageView * _headView;
    UILabel * _themeTitle;
    UILabel * _headLabel;
    UIButton * _backButton;
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger length;
@property (nonatomic,strong)SubjectHeadModel * dataModel;
@end

@implementation ZYCSubjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self createHeadLabel];
    [self createTableView];
    [self createFrexibleImageView];
    [self createRefreshing];
    [self loadFirstData];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [footer free];
}
-(void)createRefreshing
{
    
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView; // 或者tableView
    footer.delegate = self;
}
#pragma  mark 刷新代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    [_dataArray removeAllObjects];
    
        //尾部
        self.length+=10;
        [self loadDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
            [MBProgressHUD showError:@"下拉数据请求失败,可能网络慢哦"];
        }];
        
    
    
    
}
#pragma  mark 数据部分
-(void)initData
{
    if (nil ==_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    if (nil ==_dataModel) {
        _dataModel =[[SubjectHeadModel alloc]init];
    }
}
-(void)loadFirstData
{
    NSArray * array =[self.link componentsSeparatedByString:@"="];
    
    NSString * subjectid =array.lastObject;
    NSString * headurl =[NSString stringWithFormat:ZYC_GROUND_HEAD_URL,subjectid];
    [RequestTool GET:headurl parameters:nil success:^(id responseObject) {
        NSDictionary * dict =responseObject;
        NSDictionary * modeldict =dict[@"obj"][@"head"];
        [_dataModel setValuesForKeysWithDictionary:modeldict];
        [self refreshHeadView];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"数据请求失败,可能网络慢哦"];
    }];
    NSString * listurl =[NSString stringWithFormat:ZYC_GROUND_TOURLIST_URL, subjectid,self.length];
    [RequestTool GET:listurl parameters:nil success:^(id responseObject) {
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        for (NSDictionary * dd in array) {
            NSArray * tmpArray =dd[@"list"];
            NSArray * modelArray =[SFTour objectArrayWithKeyValuesArray:tmpArray];
            [_dataArray addObjectsFromArray:modelArray];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"数据请求失败,可能网络慢哦"];
    }];
    
}
//刷新HeadView
-(void)refreshHeadView
{
    NSString * imageUrlStr =[NSString stringWithFormat:@"%@%@%@",_dataModel.picdomain,SMALL_IMAGE,_dataModel.coverpic];
    [_headView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    _themeTitle.text =_dataModel.name;
    //[_dataModel.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{nsat} context:nil];
   // _headLabel.text =
}
-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    
    NSArray * array =[self.link componentsSeparatedByString:@"="];
    
    NSString * subjectid =array.lastObject;
    
    NSString * listurl =[NSString stringWithFormat:ZYC_GROUND_TOURLIST_URL, subjectid,self.length];
    //CXLog(@"~~%@",self.link);
    [RequestTool GET:listurl parameters:nil success:^(id responseObject) {
        
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




-(void)createHeadLabel
{
    if (nil ==_headLabel) {
        _headLabel =[[UILabel alloc]init];
    }
}

-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT ) style:UITableViewStylePlain];
    _tableView.contentInset =UIEdgeInsetsMake(180*SCREEN_WIDTH/320, 0, 0, 0) ;
    _tableView.contentOffset=CGPointMake(0,-180*SCREEN_WIDTH/320 );
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    _tableView.tableHeaderView =_headLabel;
    [self.view addSubview:_tableView];
    
}
-(void)createFrexibleImageView
{
    _headView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -180*SCREEN_WIDTH/320, SCREEN_WIDTH, 180*SCREEN_WIDTH/320)];
    _headView.userInteractionEnabled =YES;
    [_tableView addSubview:_headView];
    _backButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20*SCREEN_WIDTH/320, 20*SCREEN_WIDTH/320)];
    [_backButton setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_backButton];
    _themeTitle =[[UILabel alloc]initWithFrame:CGRectMake(0, 60*SCREEN_WIDTH/320, SCREEN_WIDTH,60*SCREEN_WIDTH/320 )];
    _themeTitle.textAlignment =NSTextAlignmentCenter;
    [_headView addSubview:_themeTitle];
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =NO;
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
