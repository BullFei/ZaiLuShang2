//
//  SquareVC.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SquareVC.h"

#import "GroundTableView.h"
#import "ADView.h"
#import "JingXuanCell.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "RequestTool.h"

#import "ADModel.h"
#import "JingXuanModel.h"
#import "Section2ItemModel.h"
#import "TripTopicModel.h"
#import "MoreThemeModel.h"
#import "SpecialColumnModel.h"

#import "ZYCADWebViewController.h"
#import "ZYCJingXuanListViewController.h"
#import "ZYCSubjectListViewController.h"
#import "ZYCTripTopicListViewController.h"
#import "ZYCMoreThemeListViewController.h"
#import "SFTourDayVC.h"

#define  GROUND_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=getPlaza&length=20&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0"
@interface SquareVC ()
{
    NSTimer * _timer;
    GroundTableView * _groundTableView;
    NSMutableArray * _ADModelArray;
    NSMutableArray * _JingXuanMModelArray;
    NSMutableArray * _section2ItemModelArray;
    NSMutableArray * _tripTopicModelArray;
    NSMutableArray * _moreThemeModelArray;
    NSMutableArray * _specialColumnModelArray;
}
@end


@implementation SquareVC
-(void)dealloc
{
    if (_timer) {
        [_timer invalidate];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createTimer];
    [self initDataArray];
    [self createData];
    CXLog(@"%f", CGW(self.view));
    // Do any additional setup after loading the view.
}

//数据部分
-(void)initDataArray
{
    _ADModelArray =[[NSMutableArray alloc]init];
    _JingXuanMModelArray =[[NSMutableArray alloc]init];
    _section2ItemModelArray =[[NSMutableArray alloc]init];
    _tripTopicModelArray =[[NSMutableArray alloc]init];
    _moreThemeModelArray =[[NSMutableArray alloc]init];
    _specialColumnModelArray =[[NSMutableArray alloc]init];
}

-(void)createData
{
//    [RequestTool GET:<#(NSString *)#> parameters:<#(id)#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil];
    [manager GET:GROUND_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //拿到每种模型的数组吧，这就么1个URL里，这么多模型，你说坑不吭
        
        NSDictionary * dict =responseObject;
        NSDictionary * subdict =dict[@"obj"];
        NSArray * array =subdict[@"list"];
        
        //首先拿到ADModel的数组
        NSDictionary * ADModelDict = [array firstObject];
        NSArray * ADModelTempArray = ADModelDict[@"list"];

        NSArray * tempADModelArray =[ADModel objectArrayWithKeyValuesArray:ADModelTempArray];
        [_ADModelArray addObjectsFromArray:tempADModelArray];
        _groundTableView.ADModelArray =_ADModelArray;
        //拿到JingXuanModel的数组
        for (int i =2; i<7; i++) {
            NSDictionary * dict =[array objectAtIndex:i];
            NSArray * tempArray =dict[@"list"];
            JingXuanModel * mm =[JingXuanModel objectArrayWithKeyValuesArray:tempArray].firstObject ;
            
            [_JingXuanMModelArray addObject:mm];
        }
        
        _groundTableView.JingXuanModelArray =_JingXuanMModelArray;
        //拿到Section2ItemModel
        {
            NSDictionary * dict =[array objectAtIndex:8];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[Section2ItemModel objectArrayWithKeyValuesArray:tempArray];
            [_section2ItemModelArray addObjectsFromArray:ttArr];
            
        }
        {
            NSDictionary * dict =[array objectAtIndex:9];
            NSArray * tempArray=dict[@"list"];
            NSArray * ttArr =[Section2ItemModel objectArrayWithKeyValuesArray:tempArray];
            [_section2ItemModelArray addObjectsFromArray:ttArr];
        }
        _groundTableView.Section2ItemModelArray =_section2ItemModelArray;
        
        //拿到triptopicmodel
        for (int i =23; i<26; i++) {
            NSDictionary * dict =[array objectAtIndex:i];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[TripTopicModel objectArrayWithKeyValuesArray:tempArray];
            [_tripTopicModelArray addObjectsFromArray:ttArr];
            
        }
        _groundTableView.TripTopicModelArray =_tripTopicModelArray;
        //拿到morethememodel
        for (int i =27; i<=30; i++) {
            NSDictionary * dict =[array objectAtIndex:i];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[MoreThemeModel objectArrayWithKeyValuesArray:tempArray];
            [_moreThemeModelArray addObjectsFromArray:ttArr];
        }
        _groundTableView.MoreThemeModelArray =_moreThemeModelArray;
        //拿到specialcolumnmodel
        {
            NSDictionary * dict =[array objectAtIndex:1];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[SpecialColumnModel objectArrayWithKeyValuesArray:tempArray];
            [_specialColumnModelArray addObjectsFromArray:ttArr];
            
        }
        {
            
            NSDictionary * dict =[array objectAtIndex:7];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[SpecialColumnModel objectArrayWithKeyValuesArray:tempArray];
            [_specialColumnModelArray addObjectsFromArray:ttArr];
            
        }
        {
            
            NSDictionary * dict =[array objectAtIndex:22];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[SpecialColumnModel objectArrayWithKeyValuesArray:tempArray];
            [_specialColumnModelArray addObjectsFromArray:ttArr];
        }
        {
            
            NSDictionary * dict =[array objectAtIndex:26];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[SpecialColumnModel objectArrayWithKeyValuesArray:tempArray];
            [_specialColumnModelArray addObjectsFromArray:ttArr];
        }
        _groundTableView.SpecialColumnModelArray =_specialColumnModelArray;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}

-(void)createUI
{
   _groundTableView =[GroundTableView createTableViewWithFrame:self.view.bounds];
    [self.view addSubview:_groundTableView];
    
    __weak SquareVC * svc =self;
    _groundTableView.ADViewPushBlock=^(NSString * url){
        
        ZYCADWebViewController * advc =[[ZYCADWebViewController alloc]init];
        advc.ADWebUrl =url;
        [svc.navigationController pushViewController:advc animated:YES];

    };
    _groundTableView.JingXuanHeadViewPushBlock=^{
        ZYCJingXuanListViewController * jxlvc =[[ZYCJingXuanListViewController alloc]init];
        jxlvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:jxlvc animated:YES];
    };
    _groundTableView.Section2HeadViewPushBlock=^(NSString * link){
        ZYCSubjectListViewController * slvc=[[ZYCSubjectListViewController alloc]init];
        slvc.link =link;
        slvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:slvc animated:YES];
        
    };
    _groundTableView.TripTopicHeadViewPushBlock=^(NSString * link){
        ZYCTripTopicListViewController * ttlvc =[[ZYCTripTopicListViewController alloc]init];
        ttlvc.link =link;
        ttlvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:ttlvc animated:YES];
    };
    _groundTableView.MoreThemeHeadViewPushBlock =^{
        ZYCMoreThemeListViewController * mtlvc =[[ZYCMoreThemeListViewController alloc]init];
       // mtlvc.link =link;
        mtlvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:mtlvc animated:YES];
        
    };
    _groundTableView.JingXuanCellPushBlock=^(JingXuanModel * mm){
        SFTourDayVC * tdvc =[[SFTourDayVC alloc]init];
        tdvc.tour =mm;
        tdvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:tdvc animated:YES];
    };
    
    _groundTableView.section2ItemPushBlock=^(Section2ItemModel *mm){
        SFTourDayVC * tdvc =[[SFTourDayVC alloc]init];
        tdvc.tour =mm;
        tdvc.hidesBottomBarWhenPushed =YES;
        [svc.navigationController pushViewController:tdvc animated:YES];
    };
//    ADView * adv =(id)[self.view viewWithTag:1];
//    
//    adv.pushBlock=^(NSString * url){
//        //ZYCADWebViewController * advc =[[ZYCADWebViewController alloc]init];
//        //advc.ADWebUrl =url;
//        //[self.navigationController pushViewController:advc animated:YES];
//    };
}
-(void)createTimer
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

-(void)refresh
{
   ADView * adv =(id)[self.view viewWithTag:1];
    UIScrollView * sv =[adv getSCrollView];
   
    if (sv.isDragging==NO&&sv.isDecelerating==NO) {
        [adv refresh];
    }
    
    for (int i =0; i<5; i++) {
        JingXuanCell * jxc =(id)[self.view viewWithTag:GROUND_JINGXUANCELL_INITTAG+i];
        [jxc refreshCommentsScrollView];
    }
    
   // [adv refresh];
    
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
