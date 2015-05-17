//
//  GroundTableView.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GroundTableView.h"
#import "ADView.h"
#import "SpecialColumnView.h"

#import "MJExtension.h"

#import "JingXuanCell.h"
#import "Section2Cell.h"
#import "TripTopicCell.h"
#import "MoreThemeCell.h"


@implementation GroundTableView
{
    UITableView * _tableView;
    ADView * adview;
    SpecialColumnView * scv1;//精选
    SpecialColumnView * scv2;//打手牵小手
    SpecialColumnView * scv3;//旅行话题
    
    SpecialColumnView * scv4;//更多专题
}

+(GroundTableView *)createTableViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self createTableViewUIWithFrame:frame];
        //[self createADView];
    }
    return self;
}
-(void)setADModelArray:(NSArray *)ADModelArray
{
    _ADModelArray =ADModelArray;
    [_tableView reloadData];
}
-(void)setJingXuanModelArray:(NSArray *)JingXuanModelArray
{
    _JingXuanModelArray =JingXuanModelArray;
//    JingXuanModel * jxm =_JingXuanModelArray.firstObject;
//    NSLog(@"~~~~%@",jxm.cmt);
    [_tableView reloadData];
}
-(void)setSection2ItemModelArray:(NSArray *)Section2ItemModelArray
{
    _Section2ItemModelArray =Section2ItemModelArray;
    [_tableView reloadData];
}
-(void)setTripTopicModelArray:(NSArray *)TripTopicModelArray
{
    _TripTopicModelArray =TripTopicModelArray;
    [_tableView reloadData];
}
-(void)setMoreThemeModelArray:(NSArray *)MoreThemeModelArray
{
    _MoreThemeModelArray =MoreThemeModelArray;
    [_tableView reloadData];
}
-(void)setSpecialColumnModelArray:(NSArray *)SpecialColumnModelArray
{
    _SpecialColumnModelArray =SpecialColumnModelArray;
    [_tableView reloadData];
}

#pragma mark UI部分
-(void)createTableViewUIWithFrame:(CGRect)frame
{
    _tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.bounces =NO;
    
    [self createSpecialColumnViews];
    [self addSubview:_tableView];
}
-(void)createADView
{
     adview =[ADView createADViewWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200*_tableView.frame.size.width/320)];
    adview.tag = 1;
}
-(void)createSpecialColumnViews
{
    CGRect rect =CGRectMake(0, 0, SCREEN_WIDTH, 30/320*SCREEN_WIDTH) ;
    if (scv1==nil) {
        scv1 =[SpecialColumnView getSpecialColumnViewWithFrame:rect];
    }
    if (scv2==nil) {
        scv2 =[SpecialColumnView getSpecialColumnViewWithFrame:rect];
    }
    if (scv3==nil) {
        scv3 =[SpecialColumnView getSpecialColumnViewWithFrame:rect];
    }
    if (scv4==nil) {
        scv4 =[SpecialColumnView getSpecialColumnViewWithFrame:rect];
    }
    
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
        return 30*SCREEN_WIDTH/320;
    }
}

//carry!
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 200*SCREEN_WIDTH/320;
            break;
        case 1:
            return 230*SCREEN_WIDTH/320;
            break;
        case 2:
            return (88*2+8)*SCREEN_WIDTH/320;
            break;
        case 3:
            return 80*3*SCREEN_WIDTH/320;
            break;
        case 4:
            return (80*4+3*7)*SCREEN_WIDTH/320;
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
        switch (section) {
            case 1:
            {
                SpecialColumnModel * mm =[_SpecialColumnModelArray objectAtIndex:0];
                scv1.specialColumnModel =mm;
                return scv1;
                break;
            }
            case 2:
            {
                SpecialColumnModel * mm =[_SpecialColumnModelArray objectAtIndex:1];
                scv2.specialColumnModel =mm;
                return scv2;
            }
                break;
            case 3:
            {
                SpecialColumnModel * mm =[_SpecialColumnModelArray objectAtIndex:2];
                scv3.specialColumnModel =mm;
                return scv3;
                break;
            }
            case 4:
            {
                SpecialColumnModel * mm =[_SpecialColumnModelArray objectAtIndex:3];
                scv4.specialColumnModel =mm;
                return scv4;
                break;
            }
            default:
                return nil;
                break;
        }
        
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
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [self createADView];
                [cell.contentView addSubview:adview];

                
            }
            
//            NSLog(@"~~~~%@",self.ADModelArray);
                adview.ADModelArray =self.ADModelArray;

            
            
            //[cell.contentView addSubview:adview];
            
            return cell;
            
            
            break;
        }
        case 1:
        {
            JingXuanCell * cell =[JingXuanCell GetJingXuanCellWithTableView:tableView];
            cell.tag = GROUND_JINGXUANCELL_INITTAG+indexPath.row;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            JingXuanModel * mm =[_JingXuanModelArray objectAtIndex:indexPath.row];
           // NSLog(@"~~~%@",mm.cmt);
            NSArray * tempArr;
            if (mm.cmt) {
                tempArr =[CommentModel objectArrayWithKeyValuesArray:mm.cmt];

            }
            cell.CommentModelArray =tempArr;
            cell.jingXuanModel =mm;
            return cell;
            break;
        }
        case 2:
        {
            Section2Cell  * cell =[Section2Cell  getSection2ViewWithTableView:tableView];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.Section2ItemModelArray =_Section2ItemModelArray;
            return cell;
            break;
        }
        case 3:
        {
            
            TripTopicCell * cell =[TripTopicCell getTripTopicCellWithTableView:tableView];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.TripTopicModelArray = _TripTopicModelArray;
            return cell;
            break;
        }
        case 4:
        {
            MoreThemeCell * cell =[MoreThemeCell getMoreThemeCellWithTableView:tableView];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.moreThemeModelArray =_MoreThemeModelArray;
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
