//
//  GroundTableView.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GroundTableView.h"
#import "ADView.h"
#import "JingXuanCell.h"
#import "Section2Cell.h"
#import "TripTopicCell.h"
#import "MoreThemeCell.h"
@implementation GroundTableView
{
    UITableView * _tableView;
}

+(GroundTableView *)createTableViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self createTableViewUIWithFrame:frame];
    }
    return self;
}
-(void)setADModelArray:(NSArray *)ADModelArray
{
    _ADModelArray =ADModelArray;
    [_tableView reloadData];
}

#pragma mark UI部分
-(void)createTableViewUIWithFrame:(CGRect)frame
{
    _tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self addSubview:_tableView];
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 5; //每日精选
    }else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0.1;
    }
    else
    {
        return 30;
    }
}

//carry!
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 233;
            break;
        case 2:
            return 88*2+8;
            break;
        case 3:
            return 80*3;
            break;
        case 4:
            return 80*4+3*7;
            break;
        default:
            return 0;
            break;
    }
}
#pragma mark UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil; //广告部分没有头视图索引
    }
    else
    {
        
        return nil;
    }
}

//carry!
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString * cellId =@"AD";
            UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
               cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                
                
            }
            ADView * adview =[ADView createADViewWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
            
            adview.ADModelArray =self.ADModelArray;
            
            [cell.contentView addSubview:adview];
            
            return cell;
            
            
            break;
        }
        case 1:
        {
            JingXuanCell * cell =[JingXuanCell GetJingXuanCellWithTableView:tableView];
            return cell;
            break;
        }
        case 2:
        {
            Section2Cell  * cell =[Section2Cell  getSection2ViewWithTableView:tableView];
            return cell;
            break;
        }
        case 3:
        {
            
            TripTopicCell * cell =[TripTopicCell getTripTopicCellWithTableView:tableView];

            return cell;
            break;
        }
        case 4:
        {
            MoreThemeCell * cell =[MoreThemeCell getMoreThemeCellWithTableView:tableView];
            return cell;
            break;
        }
            
        default:
            return nil;
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
