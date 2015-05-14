//
//  SquareVC.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SquareVC.h"
#import "GroundTableView.h"
#import "AFNetworking.h"
#import "ADModel.h"
#import "MJExtension.h"
#define  GROUND_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=getPlaza&length=20&vc=anzhuo&vd=f7393db54aeaedec&token=27f3f6568d2faf418538f66d72330a23&v=a6.1.0"
@interface SquareVC ()
{
    NSTimer * _timer;
    GroundTableView * _groundTableView;
    NSMutableArray * _ADModelArray;
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
//        for (NSDictionary * ddd in ADModelTempArray) {
//            ADModel * model =[[ADModel alloc]init];
//            [model setValuesForKeysWithDictionary:ddd];
//            [_ADModelArray addObject:model];
//        }
        NSArray * tempADModelArray =[ADModel objectArrayWithKeyValuesArray:ADModelTempArray];
        [_ADModelArray addObjectsFromArray:tempADModelArray];
        _groundTableView.ADModelArray =_ADModelArray;
        
        
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
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

-(void)refresh
{
    
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
