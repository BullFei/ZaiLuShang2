//
//  SFSceneryListVC.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFSceneryListVC.h"
#import "SFSearchDisplayModule.h"
#import "RequestTool.h"
#import "SFCityTypeListModel.h"
#import "SFSceneryObjModel.h"
#import "SFCityTypeListLoc.h"
#import "SFCityTypeListWiki.h"
#import "SFCityTypeHeadTag.h"
#import "SFCityTypeHeaderPicShow.h"
#import "SFCityTypeHeaderPath.h"
#import "SFCityTypeListStaticMap.h"
#import "SFCityTypeHeadTipUser.h"
#import "SFHeaderView.h"
#import "SFCityWantedCell.h"
#import "SFStickerCell.h"
#import "SFWantPeopleVC.h"
#import "SFTourListVC.h"
#define URL @"http://app6.117go.com/demo27/php/stickerAction.php?submit=getSceneryHome&sceneryid=%ld&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0"
@interface SFSceneryListVC ()<UITableViewDataSource,UITableViewDelegate,SFStickerCellDelegate>
{
    SFSceneryObjModel * sceneryObjModel;
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SFSceneryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createBottomView];
    [self createTableView];
    [self loadData];
    

}

#pragma mark -创建nav
-(void)createNav
{
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

-(void)createBottomView
{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    bottomView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bottomView];
    
    
    NSArray * images = @[@"icon_dest_been",@"icon_dest_want"];
    NSArray * selectedImages = @[@"icon_dest_been_on",@"icon_dest_want_on"];
    NSArray * title = @[@"去过",@"想去"];
    NSArray * selectedTitle = @[@"已去过",@"已想去"];
    for(int i=0;i<2;i++){
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i*100, 10, 100, 25)];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitle:selectedTitle[i] forState:UIControlStateSelected];
        
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [bottomView addSubview:button];
    }
    
}

#pragma mark - 加载数据
-(void)loadData
{
    if (nil ==_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    NSUInteger sceneryid;
    if (self.displayModule) {
        sceneryid =self.displayModule.itemid;
    }else if (self.cityTypeListModel){
        sceneryid =self.cityTypeListModel.id;
    }
    
    [RequestTool GET:[NSString stringWithFormat:URL,sceneryid] parameters:nil success:^(id responseObject) {
        
        NSDictionary * resultDic =responseObject[@"obj"];
        sceneryObjModel = [[SFSceneryObjModel alloc]init];
        [sceneryObjModel setValuesForKeysWithDictionary:resultDic];
        
        //scenery
        NSDictionary *sceneryDic =resultDic[@"scenery"];
        SFCityTypeListModel *cityTypeListModel = [[SFCityTypeListModel alloc]init];
        [cityTypeListModel setValuesForKeysWithDictionary:sceneryDic];
        //loc
        SFCityTypeListLoc *  cityTypeListLoc = [[SFCityTypeListLoc alloc]init];
        [cityTypeListLoc setValuesForKeysWithDictionary:sceneryDic[@"loc"]];
        cityTypeListModel.cityTypeListLoc =cityTypeListLoc;
        
        //wiki
        NSArray * tempWikiArray =sceneryDic[@"wiki"];
        NSMutableArray * mulWikiArray  = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in tempWikiArray) {
            SFCityTypeListWiki * cityTypeListWiki = [[SFCityTypeListWiki alloc]init];
            [cityTypeListWiki setValuesForKeysWithDictionary:dic];
            [mulWikiArray addObject:cityTypeListWiki];
        }
        cityTypeListModel.wikiArray =mulWikiArray;
        
        //tag
        SFCityTypeHeadTag *cityTypeHeadTag = [[SFCityTypeHeadTag alloc]init];
        [cityTypeHeadTag setValuesForKeysWithDictionary:sceneryDic[@"tag"]];
        cityTypeListModel.cityTypeHeadTag =cityTypeHeadTag;
        
        //pic show
        SFCityTypeHeaderPicShow * cityTypeHeaderPicShow = [[SFCityTypeHeaderPicShow alloc]init];
        [cityTypeHeaderPicShow setValuesForKeysWithDictionary:sceneryDic[@"picShow"]];
        cityTypeListModel.cityTypeHeaderPicShow =cityTypeHeaderPicShow;
        
        //staticMap
        SFCityTypeListStaticMap * cityTypeListStaticMap = [[SFCityTypeListStaticMap alloc]init];
        [cityTypeListStaticMap setValuesForKeysWithDictionary:sceneryDic[@"staticMap"]];
        cityTypeListModel.cityTypeListStaticMap =cityTypeListStaticMap;
        
        //path
        NSArray * tempArray =sceneryDic[@"path"];
        NSMutableArray * mulArray = [[NSMutableArray alloc]init];
        for (NSDictionary * dic  in tempArray) {
            SFCityTypeHeaderPath * cityTypeHeaderPath = [[SFCityTypeHeaderPath alloc]init];
            [cityTypeHeaderPath setValuesForKeysWithDictionary:dic];
            [mulArray addObject:cityTypeHeaderPath];
        }
        cityTypeListModel.pathArray =mulArray;
        
        sceneryObjModel.scenery =cityTypeListModel;
        
        NSArray * array =resultDic[@"tip_user"];
        NSMutableArray * mulTipUsers = [[NSMutableArray alloc]init];
        for (NSDictionary * dic  in array) {
            SFCityTypeHeadTipUser * cityTypeHeadTipUser = [[SFCityTypeHeadTipUser alloc]init];
            [cityTypeHeadTipUser setValuesForKeysWithDictionary:dic];
            [mulTipUsers addObject:cityTypeHeadTipUser];
        }
        sceneryObjModel.tipUserArray =mulTipUsers;
        
        [self createTableHeaderView];
        [self createFooterView];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        CXLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark -创建头
-(void)createTableHeaderView
{
    SFHeaderView * headerView = [SFHeaderView headerView];
    headerView.sceneryObjModel = sceneryObjModel;
    _tableView.tableHeaderView =headerView;
}

#pragma mark -创建tableview
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //想去
        //wante
        SFCityWantedCell * cell = [SFCityWantedCell cellWithTableView:tableView];
        cell.sceneryObjModel =sceneryObjModel;
        return cell;
    }else if (indexPath.row==1){
        SFStickerCell * cell = [SFStickerCell cellWithTableView:tableView];
        cell.delegate =self;
        cell.sceneryObjModel = sceneryObjModel;
        return cell;
    }
    return nil;
}

-(void)createFooterView
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _tableView.tableFooterView =webView;
    [webView setUserInteractionEnabled:YES];
    [webView setOpaque:YES];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:sceneryObjModel.wiki_url]]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1||indexPath.row==0) {
        return 60;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //
        
        SFWantPeopleVC * wantPeopleVC = [[SFWantPeopleVC alloc]init];
        wantPeopleVC.displayModule =self.displayModule;
        wantPeopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wantPeopleVC animated:YES];
    }
}

-(void)stickerCell:(SFStickerCell *)stickerCell withID:(NSInteger)locid withTitle:(NSString *)title withSign:(NSString *)sign
{
    if ([sign isEqualToString:@"tour"]) {
        //游记
        SFTourListVC * tourListVC = [[SFTourListVC alloc]init];
        tourListVC.sceneryid =locid;
        tourListVC.tag =title;
        tourListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tourListVC animated:YES];
    }
}



@end
