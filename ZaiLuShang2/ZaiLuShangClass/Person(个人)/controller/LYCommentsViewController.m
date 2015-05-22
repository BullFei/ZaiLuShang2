//
//  LYCommentsViewController.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LYCommentsViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "RequestTool.h"
#import "LYComment.h"
#import "LYOwner.h"
#import "CommentHeaderCell.h"
#import "IconCell.h"
#import "CommentContentCell.h"

#define LYZLS_COMMENTS_URL @"http://app6.117go.com/demo27/php/formAction.php?submit=getCmt&onitemtype=1&onitemid=%@&length=20&vc=yingyb&vd=63f8563b8e3d7949&token=35e49d0b0a2ace978e30bb1acaa7684b&v=a6.2.0"

@interface LYCommentsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL _hasMore;
}

@end

@implementation LYCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self requestDataWithItemId:self.itemid];
    [MBProgressHUD showMessage:@"正在加载数据"];
}

- (void)createTableView {
    _hasMore = false;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
}
- (void)requestDataWithItemId:(NSString *)itemid {
    NSString *url = [NSString stringWithFormat:LYZLS_COMMENTS_URL, itemid];
//    CXLog(@"%@", url);
    [RequestTool GET:url parameters:nil success:^(id responseObject) {
        if (_dataArray == nil) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        NSDictionary *dict = (NSDictionary *)responseObject;
        for (NSDictionary *smallDict in dict[@"obj"][@"list"]) {
            LYComment *cmt = [[LYComment alloc] init];
            [cmt setValuesForKeysWithDictionary:smallDict];
            
            LYOwner *owner = [[LYOwner alloc] init];
            [owner setValuesForKeysWithDictionary:smallDict[@"user"]];
            cmt.user = owner;
            
            [_dataArray addObject:cmt];
        }
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"数据加载完成"];
        
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView reloadData];
        CXLog(@"%lu", _dataArray.count);
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"数据请求失败"];
    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataArray.count == 0) {
        return 2;
    } else {
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _dataArray.count;
    } else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CommentHeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentHeaderCell" owner:self options:nil] lastObject];
        [cell configUIWithController:self];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *identifier = @"IconCellId";
        IconCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[IconCell alloc] init];
        }
        [cell configUIWithArray:_dataArray];
        return cell;
    } else {
        static NSString *love = @"contentid";
        CommentContentCell *cell = [_tableView dequeueReusableCellWithIdentifier:love];
        if (nil == cell) {
            LYCommentFrameModel *cfm = [[LYCommentFrameModel alloc] initWithCommentModel:_dataArray[indexPath.row]];
            cell = [[CommentContentCell alloc] initWithCommentFrameModel:cfm];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 145;
    } else if (indexPath.section == 1) {
        return 50;
    } else {
        if (_dataArray.count == 0) {
            return 0;
        } else {
            LYCommentFrameModel *cfm = [[LYCommentFrameModel alloc] initWithCommentModel:_dataArray[indexPath.row]];
            return cfm.cellHeight;
        }
    }
}
@end
