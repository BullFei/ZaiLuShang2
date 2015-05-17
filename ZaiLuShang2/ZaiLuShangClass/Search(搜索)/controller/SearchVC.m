//
//  SearchVC.m
//  ChanYouJi
//
//  Created by gaocaixin on 15/5/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//bbtb

#import "SearchVC.h"
#import "RequestTool.h"
#import "SFSearchModel.h"
#import "SFLinkTitleList.h"
#import "SFTactick.h"
#import "SFTactickBanners.h"
#import "SFSearchDisplayModule.h"
#import "SFTitleCell.h"
#import "SFSceneryCellTableViewCell.h"
#import "SFTactickCell.h"
#import "SFSearchCountryCell.h"
#import "SFDetailTactickController.h"
#import "SFListTactickController.h"
#import "SFListCityVC.h"
#import "SFSceneryListVC.h"
#define  TITLE_TYPE 88 //标题
#define  TACTICK_TYPE 90 //攻略
#define  OTHER_TYPE 18 //其他
#define PUSH_TYPE_2  2//有图
#define PUSH_TYPE_3  3//无图
#define  SHOW_TYPE_SECENER  @"tag_2_1"
#define  SHOW_TYPE_COUNTRY  @"tag_2_3"
#define TACTICK_URL @"http://www.117go.com/article/osaka-koutsu?refer=DiscoverHome&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0&vc=anzhuo&vd=a1c9d9b8a69b4bf4&userid=22506751"
#define SEARCH_MAIN_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=getDiscoverHome&length=20&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SearchVC ()<UITableViewDataSource,UITableViewDelegate,SFSearchCountryCellDelegate,SFSceneryCellTableViewCellDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self loadData];
}
#pragma mark -创建tableview
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
}
#pragma mark -加载数据
-(void)loadData
{
    if (nil==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    [RequestTool GET:SEARCH_MAIN_URL parameters:nil success:^(id responseObject) {
        NSArray * tempArray =responseObject[@"obj"][@"list"];
        for (NSDictionary * dic in tempArray) {
            SFSearchModel * searchModel = [[SFSearchModel alloc]init];
            [searchModel setValuesForKeysWithDictionary:dic];
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
                searchModel.listArray =mulList;
                
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
                searchModel.listArray =mulList;
            }else if(OTHER_TYPE ==[dic[@"type"] integerValue]){
                //其他
                for (NSDictionary * listDic  in tempList) {
                    SFSearchDisplayModule * sdm = [[SFSearchDisplayModule alloc]init];
                    [sdm setValuesForKeysWithDictionary:listDic];
                    [mulList addObject:sdm];
                }
                searchModel.listArray =mulList;
            }
            [_dataArray addObject:searchModel];
        }
         [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark -代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num =[[_dataArray[section] listArray] count];
    if (num>1) {
        return num*0.5;
    }
    return num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFSearchModel * model = _dataArray[indexPath.section];
    if (TITLE_TYPE == model.type) {
        //title
        SFTitleCell * cell = [SFTitleCell cellWithTableView:tableView];
        cell.searchModel =model;
        return cell;
    }else if (TACTICK_TYPE==model.type){
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
            cell.deleagte = self;
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
            cell.delegate = self;
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
        //标题
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
    }else if (TITLE_TYPE ==model.type){
        SFListTactickController * listTactickController = [[SFListTactickController alloc]initWithStyle:UITableViewStylePlain];
        listTactickController.searchModel =model;
        [self.navigationController pushViewController:listTactickController animated:YES];
    }
}

#pragma mark - 代理方法  五月推荐
-(void)sceneryCellTableViewCellPushController:(SFSceneryCellTableViewCell *)sceneryCellTableViewCell withSearchDisplayModule:(SFSearchDisplayModule *)searchModule
{
    if (PUSH_TYPE_2 ==searchModule.type) {
        //有图模型
        SFListCityVC * listVC = [[SFListCityVC alloc]init];
        listVC.displayModule =searchModule;
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    }else if(PUSH_TYPE_3 == searchModule.type){
        //无图
        SFSceneryListVC * listVC = [[SFSceneryListVC alloc]init];
        listVC.displayModule =searchModule;
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    }
   
}

-(void)searchCountryCellPushController:(SFSearchCountryCell *)searchCountryCell withSearchDisplayModule:(SFSearchDisplayModule *)searchModule
{
    SFListCityVC * listVC = [[SFListCityVC alloc]init];
    listVC.displayModule =searchModule;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
