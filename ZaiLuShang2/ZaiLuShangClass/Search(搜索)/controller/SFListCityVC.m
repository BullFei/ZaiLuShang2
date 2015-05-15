//
//  SFListCityVC.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFListCityVC.h"
#import "SFSearchDisplayModule.h"
#import "RequestTool.h"
#import "SFCityType.h"
#import "SFCityTypeHead.h"
#import "SFCityTypeHeadLocality.h"
#import "SFCityTypeHeadTag.h"
#import "SFCityTypeHeaderPath.h"
#import "SFCityTypeHeadTipUser.h"
#import "SFCityTypeHeaderPicShow.h"
#import "SFSearchModel.h"
#import "SFLinkTitleList.h"
#import "SFCityTypeListModel.h"
#import "SFCityTypeListLoc.h"
#import "SFCityTypeListWiki.h"
#import "SFCityTypeListStaticMap.h"
#import "SFHeaderView.h"
#import "SFCityWantedCell.h"
#import "SFStickerCell.h"
#import "SFTitleCell.h"
#import "SFTactickCell.h"
#import "SFSceneryTypeFivtyCell.h"
#import "SFTour.h"
#import "SFExctingTourCell.h"
#import "SFProduct.h"
#import "SFProductCell.h"
#import "SFTactick.h"
#import "SFWantPeopleVC.h"
#import "SFTourListVC.h"
#import "SFDetailTactickController.h"
#import "SFSceneryListVC.h"
#define  TITLE_TYPE 88 //标题
#define TYPE_50  50 //旅行地
#define TYPE_4  4 //精彩游记
#define TYPE_102  102 //相关体验
#define  TACTICK_TYPE 90 //攻略
#define  MAIN_URL @"http://app6.117go.com/demo27/php/interestAction.php?submit=localityHome&locid=%ld&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SFListCityVC ()<UITableViewDelegate,UITableViewDataSource,SFStickerCellDelegate,SFSceneryTypeFivtyCellDelegate>
{
    SFCityType * _cityType;
    SFCityTypeHead * cityTypeHead;
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SFListCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createTableView];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark -创建nav
-(void)createNav{
    self.navigationItem.title = self.displayModule.name;
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
#pragma mark - 加载数据
-(void)loadData
{
    if (nil ==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    [RequestTool GET:[NSString stringWithFormat:MAIN_URL,self.displayModule.itemid] parameters:nil success:^(id responseObject) {
        NSDictionary * reponseDic =responseObject[@"obj"];
        _cityType =[[SFCityType alloc]init];
        [_cityType setValuesForKeysWithDictionary:reponseDic];
        //头部
        NSDictionary * headDic =reponseDic[@"head"];
        cityTypeHead = [[SFCityTypeHead alloc]init];
        [cityTypeHead setValuesForKeysWithDictionary:headDic];
        SFCityTypeHeadLocality * cityTypeHeadLocality = [[SFCityTypeHeadLocality alloc]init];
        [cityTypeHeadLocality setValuesForKeysWithDictionary:headDic[@"locality"]];
        //解析header tag
        SFCityTypeHeadTag * cityTypeHeadTag = [[SFCityTypeHeadTag alloc]init];
        [cityTypeHeadTag setValuesForKeysWithDictionary:headDic[@"locality"][@"Tag"]];
        cityTypeHeadLocality.cityTypeHeadTag =cityTypeHeadTag;
        
        //path
        NSMutableArray * mulPaths = [[NSMutableArray alloc]init];
        NSArray * pathArray =headDic[@"locality"][@"path"];
        for (NSDictionary * dic  in pathArray) {
             SFCityTypeHeaderPath * cityTypeHeaderPath = [[SFCityTypeHeaderPath alloc]init];
            [cityTypeHeaderPath setValuesForKeysWithDictionary:dic];
            [mulPaths addObject:cityTypeHeaderPath];
        }
        cityTypeHeadLocality.paths =mulPaths;
        //pic show
        SFCityTypeHeaderPicShow * cityTypeHeaderPicShow = [[SFCityTypeHeaderPicShow alloc]init];
        [cityTypeHeaderPicShow setValuesForKeysWithDictionary:headDic[@"locality"][@"picShow"]];
        cityTypeHeadLocality.cityTypeHeaderPicShow =cityTypeHeaderPicShow;
        cityTypeHead.cityTypeHeadLocality =cityTypeHeadLocality;
        //tip_user
        NSArray * tipUses =headDic[@"tip_user"];
        NSMutableArray * mulTipUsers = [[NSMutableArray alloc]init];
        for (NSDictionary * dic  in tipUses) {
            SFCityTypeHeadTipUser * cityTypeHeadTipUser = [[SFCityTypeHeadTipUser alloc]init];
            [cityTypeHeadTipUser setValuesForKeysWithDictionary:dic];
            [mulTipUsers addObject:cityTypeHeadTipUser];
        }
        cityTypeHead.tip_users =mulTipUsers;
        
        [_dataArray addObject:cityTypeHead];
        [_dataArray addObject:cityTypeHead];
        
        //list
        NSArray * listArray =reponseDic[@"list"];
        for (NSDictionary * listDic  in listArray) {
            SFSearchModel * searchModel = [[SFSearchModel alloc]init];
            [searchModel setValuesForKeysWithDictionary:listDic];
            NSArray * tempList =listDic[@"list"];
            NSMutableArray * mulList = [[NSMutableArray alloc]init];
            if (TITLE_TYPE ==[listDic[@"type"] integerValue]) {
                //标题
                for (NSDictionary * listDic  in tempList) {
                    SFLinkTitleList * linkTitleList = [[SFLinkTitleList alloc]init];
                    [linkTitleList setValuesForKeysWithDictionary:listDic];
                    [mulList addObject:linkTitleList];
                }
                
            }else if (TACTICK_TYPE ==[listDic[@"type"] integerValue]){
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

            }
            else if(TYPE_50 ==[listDic[@"type"] integerValue]){
                //其他
                for (NSDictionary * listDic  in tempList) {
                    SFCityTypeListModel * cityTypeListModel = [[SFCityTypeListModel alloc]init];
                    [cityTypeListModel setValuesForKeysWithDictionary:listDic];
                    //loc
                    SFCityTypeListLoc *  cityTypeListLoc = [[SFCityTypeListLoc alloc]init];
                    [cityTypeListLoc setValuesForKeysWithDictionary:listDic[@"loc"]];
                    cityTypeListModel.cityTypeListLoc =cityTypeListLoc;
                    
                    //wiki
                    NSArray * tempWikiArray =listDic[@"wiki"];
                    NSMutableArray * mulWikiArray  = [[NSMutableArray alloc]init];
                    for (NSDictionary * dic in tempWikiArray) {
                        SFCityTypeListWiki * cityTypeListWiki = [[SFCityTypeListWiki alloc]init];
                        [cityTypeListWiki setValuesForKeysWithDictionary:dic];
                        [mulWikiArray addObject:cityTypeListWiki];
                    }
                    cityTypeListModel.wikiArray =mulWikiArray;
                    
                    //tag
                    SFCityTypeHeadTag *cityTypeHeadTag = [[SFCityTypeHeadTag alloc]init];
                    [cityTypeHeadTag setValuesForKeysWithDictionary:listDic[@"tag"]];
                    cityTypeListModel.cityTypeHeadTag =cityTypeHeadTag;
                    
                    //pic show
                    SFCityTypeHeaderPicShow * cityTypeHeaderPicShow = [[SFCityTypeHeaderPicShow alloc]init];
                    [cityTypeHeaderPicShow setValuesForKeysWithDictionary:listDic[@"picShow"]];
                    cityTypeListModel.cityTypeHeaderPicShow =cityTypeHeaderPicShow;
                    
                    //staticMap
                    SFCityTypeListStaticMap * cityTypeListStaticMap = [[SFCityTypeListStaticMap alloc]init];
                    [cityTypeListStaticMap setValuesForKeysWithDictionary:listDic[@"staticMap"]];
                    cityTypeListModel.cityTypeListStaticMap =cityTypeListStaticMap;
                    
                    //path
                    NSArray * tempArray =listDic[@"path"];
                    NSMutableArray * mulArray = [[NSMutableArray alloc]init];
                    for (NSDictionary * dic  in tempArray) {
                        SFCityTypeHeaderPath * cityTypeHeaderPath = [[SFCityTypeHeaderPath alloc]init];
                        [cityTypeHeaderPath setValuesForKeysWithDictionary:dic];
                        [mulArray addObject:cityTypeHeaderPath];
                    }
                    cityTypeListModel.pathArray =mulArray;
                    [mulList addObject:cityTypeListModel];
                    
                }
               
            }else if (TYPE_4==[listDic[@"type"] integerValue]){
                for (NSDictionary * dic  in tempList) {
                    
                    SFTour * tour = [[SFTour alloc]init];
                    [tour setValuesForKeysWithDictionary:dic];
                    //members
                    NSArray * users = dic[@"members"];
                    NSMutableArray * mulUser = [[NSMutableArray alloc]init];
                    for (NSDictionary * userDic  in users) {
                         SFCityTypeHeadTipUser *cityTypeHeadTipUser = [[SFCityTypeHeadTipUser alloc]init];
                        [cityTypeHeadTipUser setValuesForKeysWithDictionary:userDic];
                        [mulUser addObject:mulUser];
                    }
                    tour.memberArray =mulUser;
                    
                    //owner
                    SFCityTypeHeadTipUser * owner = [[SFCityTypeHeadTipUser alloc]init];
                    [owner setValuesForKeysWithDictionary:dic[@"owner"]];
                    tour.cityTypeHeadTipUser =owner;
                    
                    [mulList addObject:tour];
                   
                }
            }else if (TYPE_102 == [listDic[@"type"] integerValue]){
                for (NSDictionary * dic  in tempList){
                    SFProduct * product = [[SFProduct alloc]init];
                    [product setValuesForKeysWithDictionary:dic];
                    [mulList addObject:product];
                }
            }
            searchModel.listArray =mulList;
            [_dataArray addObject:searchModel];
            
            
        }
        [self createTableHeaderView];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        CXLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark -创建头
-(void)createTableHeaderView
{
    SFHeaderView * headerView = [SFHeaderView headerView];
    headerView.cityTypeHead = cityTypeHead;
    _tableView.tableHeaderView =headerView;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==1||section==0){
        return 1;
    }else{
        SFSearchModel * searchModel = _dataArray[section];
        if(TYPE_50 ==searchModel.type){
            //旅行地
            return searchModel.listArray.count/3;
        }else if (TYPE_4==searchModel.type){
            return searchModel.listArray.count/2;
        }else if (TYPE_102==searchModel.type){
             return searchModel.listArray.count/2;
        }
        return searchModel.listArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //wante
        SFCityWantedCell * cell = [SFCityWantedCell cellWithTableView:tableView];
        cell.cityTypeHead = _dataArray[indexPath.section];
        return cell;
    }else if(indexPath.section==1){
        SFStickerCell * cell = [SFStickerCell cellWithTableView:tableView];
        cell.delegate = self;
         cell.cityTypeHead = _dataArray[indexPath.section];
        return cell;
        
    }else{
        SFSearchModel * searchModel = _dataArray[indexPath.section];
        if (TITLE_TYPE==searchModel.type) {
            //title
            SFTitleCell * cell = [SFTitleCell cellWithTableView:tableView];
            cell.searchModel =searchModel;
            return cell;
        }else if (TACTICK_TYPE==searchModel.type){
            //攻略
            SFTactickCell * cell=  [SFTactickCell cellWithTableView:tableView];
            cell.searchModel =searchModel;
            return cell;
        }else if (TYPE_50 ==searchModel.type){
            //旅行地
            SFSceneryTypeFivtyCell * cell = [SFSceneryTypeFivtyCell cellWthTableView:tableView];
            cell.searchModel =searchModel;
            cell.delegate = self;
            return cell;
            
        }else if (TYPE_4==searchModel.type){
            //精彩游记
            SFExctingTourCell * cell =[SFExctingTourCell cellWithTableView:tableView];
            cell.searchModel =searchModel;
            return cell;
        }else if (TYPE_102==searchModel.type){
            //相关体验
            SFProductCell * cell = [SFProductCell cellWithTableView:tableView];
            cell.searchModel =searchModel;
            return cell;
        }
        return nil;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }else if(indexPath.section==1){
        return 60;
    }else{
        SFSearchModel * searchModel = _dataArray[indexPath.section];
        if (TACTICK_TYPE==searchModel.type) {
            return SCREEN_WIDTH*HUANGJINGSHU*0.5;
        }else if (TYPE_50 ==searchModel.type){
             //旅行地
            return (SCREEN_WIDTH-2*6)/3+3;
        }else if (TYPE_4 ==searchModel.type){
            //精彩游记
            return (SCREEN_WIDTH-6)*HUANGJINGSHU*0.5;
        }else if (TYPE_102==searchModel.type){
            return (SCREEN_WIDTH-6)*HUANGJINGSHU*HUANGJINGSHU+72;
        }
    }
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {

        SFWantPeopleVC * wantPeopleVC = [[SFWantPeopleVC alloc]init];
        wantPeopleVC.displayModule =self.displayModule;
        wantPeopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wantPeopleVC animated:YES];
    }else{
        SFSearchModel * searchModel = _dataArray[indexPath.section];
        if (TACTICK_TYPE==searchModel.type) {
            //
            SFDetailTactickController * vc= [[SFDetailTactickController alloc]init];
            vc.searchModel =searchModel;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 贴士.游记 delegate
-(void)stickerCell:(SFStickerCell *)stickerCell withID:(NSInteger)locid withTitle:(NSString *)title withSign:(NSString *)sign
{
    if ([sign isEqualToString:@"tour"]) {
        //游记
        SFTourListVC * tourListVC = [[SFTourListVC alloc]init];
        tourListVC.locid =locid;
        tourListVC.tag =title;
        tourListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tourListVC animated:YES];
    }
}

#pragma mark -旅行地
-(void)sceneryTypeFivtyCell:(SFSceneryTypeFivtyCell *)cell pushController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}


@end
