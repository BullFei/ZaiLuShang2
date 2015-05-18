//
//  ADView.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ADView.h"
#define BUTTON_INIT_TAG 100
//#define SCROLLVIEW_INIT_TAG 1
//#define PAGECONTROL_INIT_TAG 2
#import "UIButton+WebCache.h"
@implementation ADView
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    NSInteger totalPage; //总页数
    BOOL isLoadData;//是否已经加载数据
    //NSTimer * _timer;
}
//-(void)dealloc
//{
//    if (_timer) {
//        [_timer invalidate];
//    }
//}


-(void)setADModelArray:(NSArray *)ADModelArray
{
    
    _ADModelArray =ADModelArray;
    if (isLoadData==NO&&ADModelArray!=nil) {
        totalPage =_ADModelArray.count;
        [self createScrollView];
        [self createPageControl];
        [self createButton];
        isLoadData =YES;
    }
        //第一个button
    ADModel * admlast =[ADModelArray lastObject];
    
    UIButton * button0 =(id)[self viewWithTag:BUTTON_INIT_TAG];
    
    [button0 sd_setBackgroundImageWithURL:[NSURL URLWithString:admlast.img_large] forState:UIControlStateNormal];
    //最后一个button
    ADModel * admfirst =[ADModelArray firstObject];
    UIButton * buttonlast =(id)[self viewWithTag:BUTTON_INIT_TAG+totalPage+1];
    [buttonlast sd_setBackgroundImageWithURL:[NSURL URLWithString:admfirst.img_large] forState:UIControlStateNormal];
    NSInteger i =1;
    for (ADModel * model in ADModelArray) {
        UIButton * button =(id)[self viewWithTag:i+BUTTON_INIT_TAG];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img_large] forState:UIControlStateNormal];
        i++;
    }
}
+(ADView *)createADViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
-(UIScrollView *)getSCrollView
{
    return _scrollView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
//
        //[self createTimer];
       //[self createScrollView];
        //[self createPageControl];
        //[self createButton];
    }
    return  self;
}
#pragma mark UI界面
-(void)createScrollView
{
    if (_scrollView==nil) {
        _scrollView =[[UIScrollView alloc]initWithFrame:self.bounds];
    }
    
    _scrollView.contentSize =CGSizeMake(self.frame.size.width*(totalPage+2), self.frame.size.height);
    _scrollView.contentOffset =CGPointMake(self.frame.size.width, 0);
    _scrollView.delegate =self;
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces =NO;
    //_scrollView.tag =SCROLLVIEW_INIT_TAG;
    [self addSubview:_scrollView];
}

-(void)createPageControl
{
    
    if (_pageControl ==nil) {
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0.875*self.frame.size.height, self.frame.size.width, self.frame.size.height*0.125)];
    }
    
   // _pageControl.backgroundColor =[UIColor redColor];
    _pageControl.numberOfPages =totalPage;
    [_pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
   // _pageControl.tag =PAGECONTROL_INIT_TAG;
    [self addSubview:_pageControl];
    
    
}
-(void)createButton
{
    for (int i =0; i<totalPage+2; i++) {
        UIButton * ADbutton =[[UIButton alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        ADbutton.tag =BUTTON_INIT_TAG+i;
        [ADbutton addTarget:self action:@selector(ADbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        ADbutton.backgroundColor=[UIColor greenColor];
        [_scrollView addSubview:ADbutton];
    }
    
}
#pragma  mark  事件部分
-(void)valueChanged:(UIPageControl *)pc
{
    NSUInteger currentPage=pc.currentPage;
    [_scrollView setContentOffset:CGPointMake((currentPage+1)*self.frame.size.width, 0) animated:YES];
    
    
    
}
-(void)ADbuttonClick:(UIButton *)button
{
    NSLog(@"~~%ld",button.tag);
}

#pragma mark 时间刷新
-(void)refresh
{
    CGPoint pp =_scrollView.contentOffset;
    pp.x +=SCREEN_WIDTH;
    _scrollView.contentOffset =pp;
    [self redirectScrollViewContentOffset:_scrollView];
    //[self scrollViewDidEndDecelerating:_scrollView];
}
//-(void)createTimer
//{
//    _timer =[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
//    [_timer setFireDate:[NSDate distantFuture]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_timer setFireDate:[NSDate distantPast]];
//    });
//}


#pragma mark UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //[_timer setFireDate:[NSDate distantFuture]];
}
-(void)redirectScrollViewContentOffset:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==0) {
        [scrollView setContentOffset:CGPointMake(totalPage*self.frame.size.width, 0)];
        _pageControl.currentPage = totalPage-1;
        
    }else if(scrollView.contentOffset.x ==(totalPage+1)*self.frame.size.width)
    {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        _pageControl.currentPage =0;
    }else
    {
        _pageControl.currentPage =scrollView.contentOffset.x/self.frame.size.width-1;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self redirectScrollViewContentOffset:scrollView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_timer setFireDate:[NSDate distantPast]];
//    });
    //[_timer setFireDate:[NSDate distantPast]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
