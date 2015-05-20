
//
//  SFWantPeopleVC.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFWantPeopleVC.h"
#import "SFSearchDisplayModule.h"
#import "RequestTool.h"
#import "SFCityTypeHeadTipUser.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SFUserListCell.h"
#import "MBProgressHUD+MJ.h"
#define LENGTH 20
#define WANT_URL @"http://app6.117go.com/demo27/php/discoverAction.php?submit=getCheckUserList506&checktype=%@&itemtype=40&itemid=%ld&length=%ld&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SFWantPeopleVC ()<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    UIButton * leftButton;
    UIButton * rightButton;
}
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)NSString * sign;
@end

@implementation SFWantPeopleVC


-(void)viewWillAppear:(BOOL)animated
{
    self.index = 1;
    self.sign = @"visited";
    leftButton.selected = YES;
    [header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRefreshing];
}

#pragma mark -创建nav
-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //中间view
    UIView * centerView = [[UIView alloc]init];
    leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [centerView addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"button_seg_left_on.9"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"button_seg_left.9"] forState:UIControlStateSelected];
    [leftButton setTitle:@"去过" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    rightButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 0, 80, 30)];
    [centerView addSubview:rightButton];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"button_seg_right_on.9"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"button_seg_right.9"] forState:UIControlStateSelected];
    [rightButton setTitle:@"想去" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
     rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    centerView.frame = CGRectMake(0, 0, 160, 30);
    
    self.navigationItem.titleView =centerView;
    
}
#pragma mark -去过
-(void)leftBtnClick:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        rightButton.selected = NO;
        if (_dataArray.count>0) {
            [_dataArray removeAllObjects];
        }
        self.index = 1;
        self.sign =@"visited";
        [header beginRefreshing];
    }
}

-(void)rightBtnClick:(UIButton *)btn{
    if (!btn.selected) {
         btn.selected = YES;
        leftButton.selected = NO;
        if (_dataArray.count>0) {
            [_dataArray removeAllObjects];
        }
        self.index = 1;
        self.sign =@"wantgo";
        [header beginRefreshing];
    }
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
    NSString * url = [NSString stringWithFormat:WANT_URL,self.sign,self.displayModule.itemid,LENGTH*self.index];
    [RequestTool GET:url parameters:nil success:^(id responseObject) {
        NSArray * array = responseObject[@"obj"][@"list"];
        for (NSInteger i=(self.index-1)*20; i<self.index*20; i++) {
            SFCityTypeHeadTipUser * user = [[SFCityTypeHeadTipUser alloc]init];
            [user setValuesForKeysWithDictionary:array[i]];
            [_dataArray addObject:user];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFUserListCell * cell = [SFUserListCell cellWithTableView:tableView];
    cell.user = _dataArray[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
