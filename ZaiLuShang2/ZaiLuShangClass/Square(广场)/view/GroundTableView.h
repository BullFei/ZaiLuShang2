//
//  GroundTableView.h
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GROUND_JINGXUANCELL_INITTAG 10
@class JingXuanModel,Section2ItemModel;
@interface GroundTableView : UIView <UITableViewDataSource,UITableViewDelegate>
+(GroundTableView *)createTableViewWithFrame:(CGRect)frame;
@property (nonatomic,weak)NSArray * ADModelArray;
@property (nonatomic,weak)NSArray * JingXuanModelArray;
@property (nonatomic,weak)NSArray * Section2ItemModelArray;
@property (nonatomic,weak)NSArray * TripTopicModelArray;
@property (nonatomic,weak)NSArray * MoreThemeModelArray;
@property (nonatomic,weak)NSArray * SpecialColumnModelArray;

//block
@property (nonatomic,copy)void(^ADViewPushBlock)(NSString *);
@property (nonatomic,copy)void(^JingXuanHeadViewPushBlock)(void);
@property (nonatomic,copy)void(^Section2HeadViewPushBlock)(NSString * );
@property (nonatomic,copy)void(^TripTopicHeadViewPushBlock)(NSString * link);
@property (nonatomic,copy)void(^MoreThemeHeadViewPushBlock)(void);

@property (nonatomic,copy)void(^JingXuanCellPushBlock)(JingXuanModel *);
@property (nonatomic,copy)void(^section2ItemPushBlock)(Section2ItemModel *);
//@property (nonatomic,weak)NSArray * CommentModelArray;
@end
