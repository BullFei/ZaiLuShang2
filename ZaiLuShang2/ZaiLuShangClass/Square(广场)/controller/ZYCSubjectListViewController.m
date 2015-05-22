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

#import "SFTourListCell.h"
#import "SFTourDayVC.h"
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
@property (nonatomic,assign)CGFloat introHeight;
@end

@implementation ZYCSubjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self createNav];
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
#pragma mark -创建nav
-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(navbackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    //self.navigationItem.title = @"每日精选";
}
-(void)navbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.length =10;
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
    CXLog(@"~~~%@",listurl);
    [RequestTool GET:listurl parameters:nil success:^(id responseObject) {
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        
        NSArray * modelArray =[SFTour objectArrayWithKeyValuesArray:array];
        [_dataArray addObjectsFromArray:modelArray];
        
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
    
    CGSize size =[_dataModel.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CXLog(@"~~~%@",NSStringFromCGSize(size));
    _headLabel.frame =CGRectMake(15,0 , size.width, size.height+50);
    _headLabel.text =_dataModel.intro;
    
    _headLabel.numberOfLines =0;
    
    _introHeight =_headLabel.frame.size.height;
    CXLog(@"~~~%f",_introHeight);
    [_tableView reloadData];
}
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _introHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headLabel;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    
    NSArray * array =[self.link componentsSeparatedByString:@"="];
    
    NSString * subjectid =array.lastObject;
    
    NSString * listurl =[NSString stringWithFormat:ZYC_GROUND_TOURLIST_URL, subjectid,self.length];
    CXLog(@"~~%@",listurl);
    [RequestTool GET:listurl parameters:nil success:^(id responseObject) {
        
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        
        NSArray * modelArray =[SFTour objectArrayWithKeyValuesArray:array];
        [_dataArray addObjectsFromArray:modelArray];
        
        
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
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    _tableView.contentInset =UIEdgeInsetsMake(180*SCREEN_WIDTH/320, 0, 0, 0) ;
    _tableView.contentOffset=CGPointMake(0,-180*SCREEN_WIDTH/320 );
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    //_tableView.tableHeaderView =_headLabel;
    [self.view addSubview:_tableView];
    
}
-(void)createFrexibleImageView
{
    _headView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -180*SCREEN_WIDTH/320, SCREEN_WIDTH, 180*SCREEN_WIDTH/320)];
    _headView.userInteractionEnabled =YES;
    [_tableView addSubview:_headView];
    _backButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 20*SCREEN_WIDTH/320, 20*SCREEN_WIDTH/320)];
    [_backButton setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_backButton];
    _themeTitle =[[UILabel alloc]initWithFrame:CGRectMake(0, 60*SCREEN_WIDTH/320, SCREEN_WIDTH,60*SCREEN_WIDTH/320 )];
    _themeTitle.textAlignment =NSTextAlignmentCenter;
    _themeTitle.font =[UIFont systemFontOfSize:40*SCREEN_WIDTH/320];
    _themeTitle.textColor =[UIColor whiteColor];
    [_headView addSubview:_themeTitle];
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY =scrollView.contentOffset.y;
    if (offsetY< -180) {
        CGRect f = _headView.frame;
        f.origin.y =offsetY;
        f.size.height =-offsetY;
        _headView.frame =f;
    }
    if (scrollView.contentOffset.y>=0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden =NO;
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden =YES;
        }];
    }
}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y>=0) {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.navigationController.navigationBarHidden =NO;
//        }];
//    }else
//    {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.navigationController.navigationBarHidden =YES;
//        }];
//    }
//    
//}


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
