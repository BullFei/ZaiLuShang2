//
//  ZYCTourTopicDetialViewController.m
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCTourTopicDetialViewController.h"

#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "Header.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "TripTopicModel.h"
#import "TieShiModel.h"
#import "TieShiCell.h"
#import "ZYCAttentionModel.h"
#import "ZYCTagsModel.h"
#import "PictureModel.h"

#define  ZYC_TOURTOPICDETAILHEAD_URL @"http://app6.117go.com/demo27/php/stickerAction.php?submit=getTagHome&tag_id=%@&vc=baiduapp&vd=dd549b57e2892849&token=09d3a335855d5a0c144055725a8a004e&v=a6.1.0" //参数tag_id
#define ZYC_TOURTOPICDETAILLIST_URL @"http://app6.117go.com/demo27/php/stickerAction.php?submit=getStickersByTagids&tagids=%@&orderType=0&stickerid=0&length=%ld&vc=baiduapp&vd=dd549b57e2892849&token=09d3a335855d5a0c144055725a8a004e&v=a6.1.0" //参数tag_id ,length
@interface ZYCTourTopicDetialViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
   
    UIImageView * _headView;
    UIButton * _backButton;
    UILabel * _titleLabel;
    UITableView * _tableView;
    MJRefreshFooterView  * footer;
    
    
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger length;
@property (nonatomic,strong)TripTopicModel * dataModel;
@property (nonatomic,assign)CGFloat cellHeight;
@end

@implementation ZYCTourTopicDetialViewController
#pragma  mark 上拉刷新
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
        _dataModel =[[TripTopicModel alloc]init];
    }
    self.length =10;
}
-(void)loadFirstData
{
    
    
    NSString * headurl =[NSString stringWithFormat:ZYC_TOURTOPICDETAILHEAD_URL,self.tagid];
    [RequestTool GET:headurl parameters:nil success:^(id responseObject) {
        NSDictionary * dict =responseObject;
        NSDictionary * modeldict =dict[@"obj"][@"tag"];
        [_dataModel setValuesForKeysWithDictionary:modeldict];
        [self refreshHeadView];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"数据请求失败,可能网络慢哦"];
    }];
    NSString * listurl =[NSString stringWithFormat:ZYC_TOURTOPICDETAILLIST_URL, self.tagid,self.length];
    CXLog(@"~~~%@",listurl);
    [RequestTool GET:listurl parameters:nil success:^(id responseObject) {
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        
        
        
        
        NSArray * modelArray =[TieShiModel objectArrayWithKeyValuesArray:array];
        //两个傻B数组
        
        [_dataArray addObjectsFromArray:modelArray];
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"数据请求失败,可能网络慢哦"];
    }];
    
}
-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    
    NSString * url =[NSString stringWithFormat:ZYC_TOURTOPICDETAILLIST_URL,self.tagid, self.length];
    [RequestTool GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        NSArray * modelArray =[TieShiModel objectArrayWithKeyValuesArray:array];
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

#pragma  mark headView部分
-(void)createFrexibleImageView
{
    _headView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -180*SCREEN_WIDTH/320, SCREEN_WIDTH, 180*SCREEN_WIDTH/320)];
    //_headView.contentMode = UIViewContentModeScaleAspectFill;
    _headView.userInteractionEnabled =YES;
    [_tableView addSubview:_headView];
    _backButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 20*SCREEN_WIDTH/320, 20*SCREEN_WIDTH/320)];
    [_backButton setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_backButton];
    _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 60*SCREEN_WIDTH/320, SCREEN_WIDTH,60*SCREEN_WIDTH/320 )];
    _titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.font =[UIFont systemFontOfSize:40*SCREEN_WIDTH/320];
    _titleLabel.textColor =[UIColor whiteColor];
    [_headView addSubview:_titleLabel];
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
//刷新HeadView
-(void)refreshHeadView
{
    
    if (_dataModel.coverpic==nil||[_dataModel.coverpic isEqualToString:@""]) {
        _tableView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.contentOffset =CGPointZero;
        
        return;
    }
    [self createFrexibleImageView];
    NSString * imageUrlStr =[NSString stringWithFormat:@"%@%@%@",_dataModel.picdomain,BIG_IMAGE,_dataModel.coverpic];
    [_headView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    _titleLabel.text =_dataModel.name;
    
    
    
    
}




#pragma mark  tabelView部分
-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    _tableView.contentInset =UIEdgeInsetsMake(180*SCREEN_WIDTH/320, 0, 0, 0) ;
    _tableView.contentOffset=CGPointMake(0,-180*SCREEN_WIDTH/320 );
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    _tableView.tableHeaderView =nil;
    [self.view addSubview:_tableView];
    
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
    return self.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count>indexPath.row) {
        
        TieShiModel * tsm =[_dataArray objectAtIndex:indexPath.row];
        ZYCAttentionModel * am =[[ZYCAttentionModel alloc]initWithModel:tsm];
        //TieShiCell * TScell = [TieShiCell getTieShiCellWithTableView:tableView attetionModel:am];
        TieShiCell * TScell =[TieShiCell getTieShiCellWithZYCAttention:am];
        
        if (tsm.tags!=nil) {
            TScell.tagsModelArray = [ZYCTagsModel objectArrayWithKeyValuesArray:tsm.tags];
        }
        if (tsm.pics!=nil) {
            TScell.pictureModelArray =[PictureModel objectArrayWithKeyValuesArray:tsm.pics];
        }
        TScell.tsm =am.tsm;
        self.cellHeight =TScell.cellHeight;
        return TScell;
    }
    return nil;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.automaticallyAdjustsScrollViewInsets =NO;
    //[self createNav];
    //[self createHeadLabel];
    [self createTableView];
    //[self createFrexibleImageView];
    [self createRefreshing];
    [self loadFirstData];
    // Do any additional setup after loading the view.
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
