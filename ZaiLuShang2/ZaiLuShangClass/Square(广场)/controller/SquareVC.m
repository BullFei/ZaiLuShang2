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

#import "AFNetworking.h"
#import "MJExtension.h"

#import "ADModel.h"
#import "JingXuanModel.h"
#import "Section2ItemModel.h"
#import "TripTopicModel.h"
#import "MoreThemeModel.h"


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
    
}

-(void)createData
{
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
            NSArray * tempArray1 =dict[@"list"];
            NSArray * ttArr1 =[Section2ItemModel objectArrayWithKeyValuesArray:tempArray1];
            [_section2ItemModelArray addObjectsFromArray:ttArr1];
            
        }
        {
            NSDictionary * dict =[array objectAtIndex:9];
            NSArray * tempArray1 =dict[@"list"];
            NSArray * ttArr1 =[Section2ItemModel objectArrayWithKeyValuesArray:tempArray1];
            [_section2ItemModelArray addObjectsFromArray:ttArr1];
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
        //拿到
        for (int i =27; i<=30; i++) {
            NSDictionary * dict =[array objectAtIndex:i];
            NSArray * tempArray =dict[@"list"];
            NSArray * ttArr =[MoreThemeModel objectArrayWithKeyValuesArray:tempArray];
            [_moreThemeModelArray addObjectsFromArray:ttArr];
        }
        _groundTableView.MoreThemeModelArray =_moreThemeModelArray;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}

-(void)createUI
{
   _groundTableView =[GroundTableView createTableViewWithFrame:self.view.bounds];
    [self.view addSubview:_groundTableView];
}
-(void)createTimer
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

-(void)refresh
{
   ADView * adv =(id)[self.view viewWithTag:1];
    
    [adv refresh];
    
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
