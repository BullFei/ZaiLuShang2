//
//  PersonVC.m
//  ChanYouJi
//
//  Created by gaocaixin on 15/5/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PersonVC.h"
#import "RequestTool.h"
#import "LYItem.h"
#import "LYOwner.h"
#import "LYRec.h"
#import "LYAchv.h"
#import "LYTour.h"
#import "LYComment.h"
#import "LYAttentionModel.h"
#import "TripCell.h"
#import "LYAttention.h"
#import "MedalCell.h"
#import "LYAchievement.h"
#import "LYMultiPicture.h"
#import "MultiPictureCell.h"

#define ZLS_PERSON_URL @"http://app6.117go.com/demo27/php/userDynamic.php?submit=getMyDynamic&startId=0&fetchNewer=1&length=40&vc=anzhuo&vd=63f8563b8e3d7949&token=35e49d0b0a2ace978e30bb1acaa7684b&v=a6.1.0"

@interface PersonVC ()<UITableViewDataSource, UITableViewDelegate, TripCellDelegate>

@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    [self createTitleView];
    
    [self requestData];
    
}

- (void)createTitleView
{

}
- (void)createTableView
{
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:table];
    self.tableView = table;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
}
/**
 *  请求数据,解析数据
 */
- (void)requestData {
    [RequestTool GET:ZLS_PERSON_URL parameters:nil success:^(id responseObject) {
        NSLog(@"数据请求成功, 开始解析数据...");
        if (_dataArray == nil) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        // 请求结果转化为字典对象
        NSDictionary *dict = (NSDictionary *)responseObject;
        // 解析数据
        for (NSDictionary *smallDict in dict[@"obj"][@"list"]) {
            // 开始解析数据
            // 判断数据是何种类型
            
            // 最外层的数据类型是相同的
            LYAttentionModel *mainModel = [[LYAttentionModel alloc] init];
            [mainModel setValuesForKeysWithDictionary:smallDict];
            
            
            NSDictionary *tempDict = smallDict[@"item"];
            if (tempDict.allValues.count != 1) {
                // 如果@"item"键对应的值不为1,说明是第三种情况 LYItme
                
                LYItem *lyit = [[LYItem alloc] init];
                lyit.piccnt = tempDict[@"piccnt"];
                
                LYOwner *owner = [[LYOwner alloc] init];
                [owner setValuesForKeysWithDictionary:tempDict[@"user"]];
                lyit.user = owner;
                
                
                LYTour *tour = [[LYTour alloc] init];
                [tour setValuesForKeysWithDictionary:tempDict[@"tour"]];
                
                LYOwner *sowner = [[LYOwner alloc] init];
                [sowner setValuesForKeysWithDictionary:tempDict[@"tour"][@"owner"]];
                
                tour.owner = sowner;
                
                
                // 评论
                NSMutableArray *comments = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in tempDict[@"tour"][@"comments"]) {
                    LYComment *cnt = [[LYComment alloc] init];
                    [cnt setValuesForKeysWithDictionary:dict];
                    [comments addObject:cnt];
                }
                tour.comments = comments;
                
                // 影像
                NSMutableArray *records = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in tempDict[@"tour"][@"records"]) {
                    LYRec *rec = [[LYRec alloc] init];
                    [rec setValuesForKeysWithDictionary:dic];
                    
                    LYOwner *on = [[LYOwner alloc] init];
                    [on setValuesForKeysWithDictionary:dic[@"owner"]];
                    rec.owner = on;
                    [records addObject:rec];
                }
                
                tour.records = records;
                lyit.tour = tour;
                
                mainModel.item = lyit;
                
                [_dataArray addObject:mainModel];
            } else {
                if ([tempDict.allKeys.lastObject isEqualToString:@"rec"]) {
                    // 对应的是LYRec
                    
                    LYRec *rec = [[LYRec alloc] init];
                    [rec setValuesForKeysWithDictionary:smallDict[@"item"][@"rec"]];
                    
                    LYOwner *owner = [[LYOwner alloc] init];
                    [owner setValuesForKeysWithDictionary:smallDict[@"item"][@"rec"][@"owner"]];
                    rec.owner = owner;
                    
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    for (NSDictionary *dic in smallDict[@"item"][@"rec"][@"comments"]) {
                        LYComment *cmt = [[LYComment alloc] init];
                        [cmt setValuesForKeysWithDictionary:dic];
                        
                        LYOwner *on = [[LYOwner alloc] init];
                        [on setValuesForKeysWithDictionary:dic[@"user"]];
                        cmt.user = on;
                        
                        [array addObject:cmt];
                    }
                    rec.comments = array;
                    
                    mainModel.item = rec;
                    [_dataArray addObject:mainModel];
                    
                } else {
                    // 对应的是arhv
                    
                    LYAchv *ach = [[LYAchv alloc] init];
                    [ach setValuesForKeysWithDictionary:smallDict[@"item"][@"achv"]];
                    LYOwner *owner = [[LYOwner alloc] init];
                    [owner setValuesForKeysWithDictionary:smallDict[@"item"][@"achv"][@"user"]];
                    ach.user = owner;
                    
                    mainModel.item = ach;
                    
                    [_dataArray addObject:mainModel];
                }
            }
        }
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
}
#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 还需要判断model的类型选择不同的cell,后续增加上
    LYAttentionModel *heihei = _dataArray[indexPath.row];
    id haha = heihei.item;
    
    if (([haha class] == [LYAchv class]) == YES)
    {
        LYAchievement *ach = [[LYAchievement alloc] initWithLYAttentionModel:heihei];
        MedalCell *cell = [[MedalCell alloc] initWithLYAttention:ach];
        return cell;
    } else if (([haha class] == [LYRec class]) == YES) {
        LYAttention *att = [[LYAttention alloc] initWithLYAttentionModel:heihei];
        TripCell *cell = [[TripCell alloc] initWithLYAttention:att];
        return cell;
    } else {
        // 九宫格图片类型
        LYMultiPicture *mp = [[LYMultiPicture alloc] initWithLYAttentionModel:heihei];
        MultiPictureCell *cell = [[MultiPictureCell alloc] initWithLYMultiPicture:mp];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYAttentionModel *heihei = _dataArray[indexPath.row];
    id haha = heihei.item;
    if ([haha class] == [LYRec class]) {
        LYAttention *att = [[LYAttention alloc] initWithLYAttentionModel:heihei];
        return att.cellHeight;
    } else if ([haha class] == [LYAchv class]) {
        LYAchievement *ach = [[LYAchievement alloc] initWithLYAttentionModel:heihei];
        return ach.cellHeight;
    } else {
        return 300;
    }
}

#pragma mark - cell事件代理方法
- (void)iconTapped:(UITapGestureRecognizer *)tgr {
    NSLog(@"点击了头像");
}
- (void)titleTapped:(UITapGestureRecognizer *)tgr {
    NSLog(@"点击了标题");
}
- (void)igTapped:(UITapGestureRecognizer *)tgr {
    NSLog(@"点击了图片");
}
- (void)contentTapped:(UITapGestureRecognizer *)tgr {
    NSLog(@"点击了内容中的链接");
}
@end
