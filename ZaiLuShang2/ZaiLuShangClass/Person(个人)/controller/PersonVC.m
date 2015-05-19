//
//  PersonVC.m
//  ChanYouJi
//
//  Created by gaocaixin on 15/5/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import "LYRec.h"
#import "LYItem.h"
#import "LYAchv.h"
#import "LYTour.h"
#import "LYOwner.h"
#import "PersonVC.h"
#import "TripCell.h"
#import "MedalCell.h"
#import "LYComment.h"
#import "MJRefresh.h"
#import "LYAttention.h"
#import "RequestTool.h"
#import "LYAchievement.h"
#import "LYMultiPicture.h"
#import "LYAttentionModel.h"
#import "MultiPictureCell.h"
#import "LYWebViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MedalViewController.h"

#define ZLS_PERSON_URL @"http://app6.117go.com/demo27/php/userDynamic.php?submit=getMyDynamic&startId=%@&fetchNewer=1&length=20&vc=anzhuo&vd=63f8563b8e3d7949&token=35e49d0b0a2ace978e30bb1acaa7684b&v=a6.1.0"

@interface PersonVC ()<UITableViewDataSource, UITableViewDelegate, TripCellDelegate, MJRefreshBaseViewDelegate, MultiPictureCellDelegate, MedalCellDelegate>

@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, weak) MJRefreshHeaderView *headerView;
@property (nonatomic, weak) MJRefreshFooterView *footerView;

@property (nonatomic, copy) NSString *startId;
@property (nonatomic, assign) BOOL hasMore;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initStartId];
    
    [self createTableView];
    
    //    [self createTitleView];
    
    [self requestDataWithStartId:self.startId];
    
    [MBProgressHUD showMessage:@"正在加载数据"];
}
- (void)initStartId {
    self.startId = @"0";
    self.hasMore = NO;
}
- (void)createTitleView
{
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"关注", @"动态"]];
    sc.frame = CGRectMake(0, 0, 140, 30);
    sc.selectedSegmentIndex = 0;
    [sc addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = sc;
}
- (void)indexChanged:(UISegmentedControl *)sc {
    
}
- (void)createTableView
{
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:table];
    self.tableView = table;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 头
    MJRefreshHeaderView *h = [MJRefreshHeaderView header];
    h.scrollView = self.tableView;
    self.headerView = h;
    h.delegate = self;
    
    // 尾
    MJRefreshFooterView *f = [MJRefreshFooterView footer];
    f.scrollView = self.tableView;
    self.footerView = f;
    f.delegate = self;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
}
/**
 *  请求数据,解析数据
 */
- (void)requestDataWithStartId:(NSString *)startId {
    NSString *requestURL = [NSString stringWithFormat:ZLS_PERSON_URL, startId];
    [RequestTool GET:requestURL parameters:nil success:^(id responseObject) {
        NSLog(@"数据请求成功, 开始解析数据...");
        if (_dataArray == nil) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        // 请求结果转化为字典对象
        NSDictionary *dict = (NSDictionary *)responseObject;
        // 解析数据
        for (NSDictionary *smallDict in dict[@"obj"][@"list"]) {
            // 给刷新标记赋值
            self.startId = dict[@"obj"][@"start"];
            self.hasMore = (BOOL)dict[@"obj"][@"hasMore"];
            
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
        // 刷新动作结束
        [self.headerView endRefreshing];
        [self.footerView endRefreshing];
        // hide
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"数据请求成功"];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"数据请求失败");
        [MBProgressHUD showError:@"请求数据失败"];
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
    LYAttentionModel *heihei = _dataArray[indexPath.row];
    id haha = heihei.item;
    
    if (([haha class] == [LYAchv class]) == YES)
    {
        // LYAch
        LYAchievement *ach = [[LYAchievement alloc] initWithLYAttentionModel:heihei];
        MedalCell *cell = [[MedalCell alloc] initWithLYAttention:ach];
        cell.delegate = self;
        return cell;
    } else if (([haha class] == [LYRec class]) == YES) {
        // LYRec
        LYAttention *att = [[LYAttention alloc] initWithLYAttentionModel:heihei];
        TripCell *cell = [[TripCell alloc] initWithLYAttention:att];
        cell.delegate = self;
        return cell;
    } else {
        // 九宫格图片类型
        LYMultiPicture *mp = [[LYMultiPicture alloc] initWithLYAttentionModel:heihei];
        MultiPictureCell *cell = [[MultiPictureCell alloc] initWithLYMultiPicture:mp];
        cell.delegate = self;
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
        LYMultiPicture *mp = [[LYMultiPicture alloc] initWithLYAttentionModel:heihei];
        return mp.cellHeight;
    }
}

#pragma mark - tripCell事件代理方法
// 头像和作者被点击的事件
- (void)tripCell:(TripCell *)cell iconTapped:(UITapGestureRecognizer *)tgr {
    LYWebViewController *wvc = [self controllerWithCell:cell andType:WebViewPageTypeUser];
    [self presentViewController:wvc animated:YES completion:nil];
}
// 标题被点击的事件
- (void)tripCell:(TripCell *)cell titleTapped:(UITapGestureRecognizer *)tgr {
    LYWebViewController *wvc = [self controllerWithCell:cell andType:WebViewPageTypeTour];
    [self presentViewController:wvc animated:YES completion:nil];
}
// 图片被点击的事件
- (void)tripCell:(TripCell *)cell imageTapped:(UITapGestureRecognizer *)tgr {
    LYWebViewController *wvc = [self controllerWithCell:cell andType:WebViewPageTypeTour];
    [self presentViewController:wvc animated:YES completion:nil];
}

- (void)readMoreButtonClicked:(TripCell *)cell {
    CXLog(@"mmmmmmmm");
}
// 点击了喜欢按钮
- (void)tripCell:(TripCell *)cell showYourLove:(UIButton *)button {
    LYRec *rec = (LYRec *)cell.attFrame.lyam.item;
    BOOL isLiked = rec.isLiked;
    // 不喜欢
    UIImage *unLike = [UIImage imageNamed:@"icon_like_line_red_24"];
    NSData *unData = UIImagePNGRepresentation(unLike);
    unLike = [UIImage imageWithData:unData scale:2];
    // 喜欢
    UIImage *image = [UIImage imageNamed:@"icon_like_32_red"];
    NSData *data = UIImagePNGRepresentation(image);
    image = [UIImage imageWithData:data scale:2];
    if (!isLiked) {
        [UIView beginAnimations:nil context:nil];
        UIImage *an = [UIImage imageNamed:@"icon_like_red_140"];
        UIImageView *iv = [[UIImageView alloc] initWithImage:an];
        iv.center = self.view.center;
        iv.bounds = CGRectMake(0, 0, 70, 70);
        [self.view addSubview:iv];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%d", (button.currentTitle.integerValue + 1)] forState:UIControlStateNormal];
        [UIView commitAnimations];
        rec.isLiked = YES;
        [self performSelector:@selector(dismissImageView:) withObject:iv afterDelay:1];
    } else {
        [button setImage:unLike forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%d", (button.currentTitle.integerValue - 1)] forState:UIControlStateNormal];
        rec.isLiked = NO;
    }
}
- (void)dismissImageView:(UIImageView *)iv {
    [UIView beginAnimations:nil context:nil];
    [iv removeFromSuperview];
    [UIView commitAnimations];
}
- (void)contentTapped:(UITapGestureRecognizer *)tgr {
    CXLog(@"点击了内容中的链接");
}
#pragma mark - MultiPictureCellDelegate
// 九宫格图片被点击
- (void)pictureCell:(MultiPictureCell *)cell imageTapped:(UITapGestureRecognizer *)tgr {
    UIImageView *iv = (UIImageView *)tgr.view;
    NSLog(@"%lu", (long)iv.tag);
    
    LYWebViewController *wvc = [self controllerWithCell:cell andType:WebViewPageTypeTour];
    [self presentViewController:wvc animated:YES completion:nil];
}

// 九宫格头像被点击
- (void)pictureCell:(MultiPictureCell *)cell iconTapped:(UITapGestureRecognizer *)tgr {
    LYWebViewController *wvc = [self controllerWithCell:cell andType:WebViewPageTypeUser];
    [self presentViewController:wvc animated:YES completion:nil];
}
/**
 *  返回一个viewcontroller
 *
 *  @param cell 传入一个cell
 *  @param type 这个Viewcontroller将要展示的类型(tour,还是user)
 *
 *  @return 返回一个viewcontroller
 */
- (LYWebViewController *)controllerWithCell:(UITableViewCell *)cell andType:(webPageType)type{
    LYWebViewController *wv = [[LYWebViewController alloc] init];
    if ([cell class] == [TripCell class]) {
        
        TripCell *aCell = (TripCell *)cell;
        LYRec *rec = (LYRec *)aCell.attFrame.lyam.item;
        
        if (type == WebViewPageTypeTour) {
            wv.tourid = rec.tourid;
            wv.pageType = WebViewPageTypeTour;
        } else {
            wv.userid = rec.userid;
            wv.pageType = WebViewPageTypeUser;
        }
    } else if ([cell class] == [MultiPictureCell class]) {
        MultiPictureCell *aCell = (MultiPictureCell *)cell;
        LYItem *item = aCell.mp.informationModel.item;
        if (type == WebViewPageTypeTour) {
            wv.pageType = WebViewPageTypeTour;
            wv.tourid = item.tour.id;
        } else {
            wv.userid = item.user.userid;
            wv.pageType = WebViewPageTypeUser;
        }
    } else {
        MedalCell *aCell = (MedalCell *)cell;
        LYAchv *ach = (LYAchv *)aCell.achFrame.lyam.item;
        wv.pageType = WebViewPageTypeUser;
        wv.userid = ach.userid;
    }
    return wv;
}
#pragma mark - MJ刷新方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if ([refreshView class] == [MJRefreshHeaderView class]) {
        [_dataArray removeAllObjects];
        _dataArray = nil;
        [self requestDataWithStartId:@"0"];
    } else {
        // 判断
        if (self.hasMore == NO) {
            // 没有更多数据就直接返回
            return;
        }
        [self requestDataWithStartId:self.startId];
    }
}
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView {
    CXLog(@"正如我心中爱你美丽,又怎能装作嘴上四大皆空");
}
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state {
    
}
#pragma mark - MedalCellDelegate
- (void)medalCell:(MedalCell *)cell iconTapped:(UITapGestureRecognizer *)tgr {
    LYWebViewController *wv = [self controllerWithCell:cell andType:WebViewPageTypeUser];
    [self presentViewController:wv animated:YES completion:nil];
}
- (void)medalCell:(MedalCell *)cell medalTapped:(UITapGestureRecognizer *)tgr {
    MedalViewController *mvc = [[MedalViewController alloc] init];
    LYAchv *ach = cell.achFrame.lyam.item;
    mvc.userid = cell.achFrame.lyam.userid;
    mvc.navigationItem.title = [NSString stringWithFormat:@"%@获得的勋章", ach.user.nickname];
    [self.navigationController pushViewController:mvc animated:YES];
}
@end
