//
//  SFListTactickController.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFListTactickController.h"
#import "RequestTool.h"
#import "SFSearchModel.h"
#import "SFTactick.h"
#import "SFLinkTitleList.h"
#import "SFSearchDisplayModule.h"
#import "SFTactickCell.h"
#import "SFSceneryCellTableViewCell.h"
#import "SFSearchCountryCell.h"
#import "SFDetailTactickController.h"
#define  TITLE_TYPE 88 //标题
#define  TACTICK_TYPE 90 //攻略
#define  OTHER_TYPE 18 //其他
#define  SHOW_TYPE_SECENER  @"tag_2_1"
#define  SHOW_TYPE_COUNTRY  @"tag_2_3"
#define URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=getDiscoverDir&pid=%d&length=10&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SFListTactickController ()
{
    NSInteger pid;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SFListTactickController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createNav];
    
}
#pragma mark -创建nav
-(void)createNav{
    self.navigationItem.title = [[self.searchModel.listArray firstObject] title];
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadData
{
    if (nil==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    [self getPID];
    [RequestTool GET:[NSString stringWithFormat:URL,pid] parameters:nil success:^(id responseObject) {
        NSArray * tempArray =responseObject[@"obj"][@"list"];
        for (NSDictionary * dic in tempArray) {
            SFSearchModel * searchModels = [[SFSearchModel alloc]init];
            [searchModels setValuesForKeysWithDictionary:dic];
            //list 数据
            NSArray * tempList = dic[@"list"];
            //临时数组
            NSMutableArray * mulList = [[NSMutableArray alloc]init];
            if (TITLE_TYPE ==[dic[@"type"] integerValue]) {
                //标题
                
                for (NSDictionary * listDic  in tempList) {
                    SFLinkTitleList * linkTitleList = [[SFLinkTitleList alloc]init];
                    [linkTitleList setValuesForKeysWithDictionary:listDic];
                    [mulList addObject:linkTitleList];
                }
                searchModels.listArray =mulList;
                
            }else if(TACTICK_TYPE ==[dic[@"type"] integerValue]){
                //攻略
                for (NSDictionary * listDic  in tempList) {
                    SFTactick * tractic = [[SFTactick alloc]init];
                    [tractic setValuesForKeysWithDictionary:listDic];
                    NSDictionary * tempBanners = listDic[@"banners"];
                    SFTactickBanners * banners = [[SFTactickBanners alloc]init];
                    [banners setValuesForKeysWithDictionary:tempBanners];
                    tractic.banner =banners;
                    [mulList addObject:tractic];
                }
                searchModels.listArray =mulList;
            }else if(OTHER_TYPE ==[dic[@"type"] integerValue]){
                //其他
                for (NSDictionary * listDic  in tempList) {
                    SFSearchDisplayModule * sdm = [[SFSearchDisplayModule alloc]init];
                    [sdm setValuesForKeysWithDictionary:listDic];
                    [mulList addObject:sdm];
                }
                searchModels.listArray =mulList;
            }
            [_dataArray addObject:searchModels];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
         CXLog(@"%@",error.localizedDescription);
    }];

}

-(void)getPID
{
    SFTactick * tactick =self.searchModel.listArray.firstObject;
    NSArray * tempArray =[tactick.link componentsSeparatedByString:@"pid="];
    pid = [tempArray[1] integerValue];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int num =[[_dataArray[section] listArray] count];
    if (num>1) {
        return num*0.5;
    }
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFSearchModel * model = _dataArray[indexPath.section];
    if (TACTICK_TYPE==model.type){
        //攻略
        SFTactickCell * cell=  [SFTactickCell cellWithTableView:tableView];
        cell.searchModel =model;
        return cell;
    }else if (OTHER_TYPE==model.type){
        //其他
        if ([SHOW_TYPE_SECENER isEqualToString:model.showType]) {
            //风景
            NSArray * displayModelArray =model.listArray;
            SFSceneryCellTableViewCell * cell =[SFSceneryCellTableViewCell cellWithTableView:tableView];
            SFSearchDisplayModule * displayModelLeft =displayModelArray[2*indexPath.row];
            SFSearchDisplayModule * displayModelRight =displayModelArray[2*indexPath.row+1];
            cell.displayModuleLeft =displayModelLeft;
            cell.displayModuleRight =displayModelRight;
            return cell;
        }else if ([SHOW_TYPE_COUNTRY isEqualToString:model.showType]){
            //国家
            SFSearchCountryCell * cell = [SFSearchCountryCell cellWithTableView:tableView];
            NSArray * displayModelArray =model.listArray;
            SFSearchDisplayModule * displayModelLeft =displayModelArray[2*indexPath.row];
            SFSearchDisplayModule * displayModelRight =displayModelArray[2*indexPath.row+1];
            cell.displayModuleLeft =displayModelLeft;
            cell.displayModuleRight =displayModelRight;
            return cell;
            
        }
    }else{
        SFTactickCell * cell=  [SFTactickCell cellWithTableView:tableView];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFSearchModel * model = _dataArray[indexPath.section];
    if (TACTICK_TYPE==model.type) {
        return SCREEN_WIDTH*HUANGJINGSHU*0.5;
    }else if ([SHOW_TYPE_SECENER isEqualToString:model.showType]){
        //风景
        return SCREEN_WIDTH*0.5-0.3;;
    }else if ([SHOW_TYPE_COUNTRY isEqualToString:model.showType]){
        //国家
        return SCREEN_WIDTH*0.5*HUANGJINGSHU;
    }else{
        return 44.0;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFSearchModel * model = _dataArray[indexPath.section];
    if (TACTICK_TYPE==model.type) {
        //攻略
        
        SFDetailTactickController * detailTactickController = [[SFDetailTactickController alloc]init];
        detailTactickController.searchModel =model;
        [self.navigationController pushViewController:detailTactickController animated:YES];
    }
}


@end
