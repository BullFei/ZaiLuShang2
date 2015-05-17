//
//  SFPhotoVC.m
//  ZaiLuShang2
//
//  Created by qianfeng on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFPhotoVC.h"
//#import "CXCollectViewCellModel.h"
@implementation SFPhotoVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.url =[NSString stringWithFormat:@"http://app6.117go.com/demo27/php/discoverAction.php?submit=getLocalityRecords&locid=%ld&length=21&vc=anzhuo&vd=a1c9d9b8a69b4bf4&token=5aa634ad2fd021650587afa999fdd184&v=a6.1.0",self.ID];
    
}


// 刷新header
- (void)refreshHeaderViewSuccess:(void (^)())success failure:(void (^)())failure
{
    [self requestDataSuccess:^(id responseObject) {
        
        NSArray *arr = [CXCollectViewCellModel objectArrayWithKeyValuesArray:responseObject[@"obj"][@"list"]];
        for (NSInteger i = arr.count-1; i >= 0 ; i--) {
            [self.dataArr insertObject:arr[i] atIndex:0];
        }
        
        [self.collectionView reloadData];
        
        if (success) {
            success();
        }
    } failure:^{
        if (failure) {
            failure();
        }
    }];


}
@end
