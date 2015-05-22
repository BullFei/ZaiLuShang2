
//
//  ZYCMoreThemeListViewController.m
//  ZaiLuShang2
//
//  Created by qianfengLQL on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCMoreThemeListViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "Header.h"
#import "MJExtension.h"

#import "MoreThemeCollectionCell.h" 
#define ZYC_GROUND_MORETHEMELIST_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=historySubjects&length=%ld&vc=baiduapp&vd=dd549b57e2892849&token=09d3a335855d5a0c144055725a8a004e&v=a6.1.0" //参数length
@interface ZYCMoreThemeListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView * header;
    MJRefreshFooterView * footer;
    UICollectionView * _collectionView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger length;
@end

@implementation ZYCMoreThemeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self initDataArray];
    
    [self createNav];
    [self createCollectionView];
    [self createRefreshing];
    [header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [header free];
    [footer free];
    
}
#pragma  mark 刷新
-(void)createRefreshing
{
    header = [MJRefreshHeaderView header];
    header.scrollView = _collectionView; // 或者tableView
    header.delegate =self;
    
    //2. 添加尾部控件的方法
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectionView; // 或者tableView
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


-(void)initDataArray
{
    
    if (nil ==_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
    }
}
-(void)loadDataSuccess:(void (^) ())success failure:(void(^)())failure
{
    
    //NSArray * array =[self.link componentsSeparatedByString:@"="];
    
   // NSString * pid =array.lastObject;
    
    NSString * url =[NSString stringWithFormat:ZYC_GROUND_MORETHEMELIST_URL, self.length];
    
    [RequestTool GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary * dict =responseObject;
        NSArray * array =dict[@"obj"][@"list"];
        for (NSDictionary * dd in array) {
            NSArray * tmpArray =dd[@"list"];
            NSArray * modelArray =[MoreThemeModel objectArrayWithKeyValuesArray:tmpArray];
            [_dataArray addObjectsFromArray:modelArray];
        }
        
        [_collectionView reloadData];
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

-(void)createNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    self.navigationItem.title = @"更多专题";
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:7];
    
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    UINib * nib =[UINib nibWithNibName:@"morethemecollectioncell" bundle:nil];
    [_collectionView registerNib: nib forCellWithReuseIdentifier:@"morethemecollection"];
    

    
    
    [self.view addSubview:_collectionView];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(157*SCREEN_WIDTH/320, 80*SCREEN_WIDTH/320);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MoreThemeCollectionCell * itemCell =[MoreThemeCollectionCell getTripTopicCollectionCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    MoreThemeModel * mm =[_dataArray objectAtIndex:indexPath.row];
    itemCell.moreThemeModel =mm;
    return itemCell;
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
