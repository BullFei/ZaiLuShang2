//
//  CXscrollView.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXscrollView.h"
#import "UIImageView+WebCache.h"
#import "CXImageDescView.h"
#import "CXScrollViewBarBtn.h"
#import "MBProgressHUD+MJ.h"
#import "CXCollectionVCell.h"
#import "CXCollectViewCellModel.h"
#import "RequestTool.h"
#import "LoginVC.h"

#define STARTTIME_DELAY 2
#define IMAGEVIEW_COUNT 3

#define IMAGEVIEW_WIDTHHEIGHT 0.8

#define SCROLLVIEW_BORDER 0
#define SCROLLVIEW_OFFSETY 64

#define BOTTOM_HEIGHT 2

#define BOTTOM_BAR_HEIGHT 49

#define BARBTN_TAG 100

#define START_ANIMATION 2

@interface CXscrollView ()<UIScrollViewDelegate>
// 主scrollView
@property (nonatomic ,weak) UIScrollView *cycleScrollView;

// 当前页码数
@property (nonatomic, assign) NSInteger currentPageIndex;

// 数据源imageURL
@property (nonatomic ,strong) NSMutableArray *imageUrls;
// 内容数据源imageURL
@property (nonatomic ,strong) NSMutableArray *contentImageUrls;
// imageview数组
@property (nonatomic ,strong) NSMutableArray *imageViews;
// 定时器
@property (nonatomic ,strong) NSTimer *time;
@property (nonatomic ,weak) UIPageControl *scrollPage;
@property (nonatomic ,weak) UIView *bottomScrollView;
@property (nonatomic ,weak) UIView *bottomView;

@property (nonatomic ,weak) UIView *bar;

@property (nonatomic ,strong) NSMutableArray *barBtnArr;

@end

@implementation CXscrollView

- (NSMutableArray *)barBtnArr
{
    if (_barBtnArr == nil) {
        _barBtnArr = [[NSMutableArray alloc] init];
    }
    return _barBtnArr;
}
- (NSMutableArray *)imageViews
{
    if (_imageViews == nil) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}
- (NSMutableArray *)imageUrls
{
    if (_imageUrls == nil) {
        _imageUrls = [[NSMutableArray alloc] init];
    }
    return _imageUrls;
}
- (NSMutableArray *)contentImageUrls
{
    if (_contentImageUrls == nil) {
        _contentImageUrls = [[NSMutableArray alloc] init];
    }
    return _contentImageUrls;
}
// 初始化函数
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 定制滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGW(self), CGH(self)-BOTTOM_BAR_HEIGHT)];
        self.cycleScrollView = scrollView;
//        scrollView.backgroundColor = [UIColor redColor];
        self.cycleScrollView.contentMode = UIViewContentModeCenter;
        self.cycleScrollView.bounces = NO;
        self.cycleScrollView.contentInset = UIEdgeInsetsMake(-64, 0, -64, 0);
        self.cycleScrollView.showsHorizontalScrollIndicator = NO;
        self.cycleScrollView.userInteractionEnabled = NO;
        self.cycleScrollView.pagingEnabled = YES;
        self.cycleScrollView.delegate = self;
        self.cycleScrollView.contentSize = CGSizeMake((IMAGEVIEW_COUNT) * CGRectGetWidth(frame), SCROLLVIEW_BORDER);
        self.cycleScrollView.contentOffset = CGPointMake(0, SCROLLVIEW_OFFSETY);
        [self addSubview:self.cycleScrollView];
        self.currentPageIndex = 0;
        
        // 添加三张imageview 用于复用
        [self addThreeImageView];
        
        // 初始化位置
        [self refreshLocation];
        
        // 底部滚动标示栏
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(INTERVAL_CELL_BORDER, CGRectGetMaxY(self.cycleScrollView.frame)-BOTTOM_HEIGHT, frame.size.width-2*INTERVAL_CELL_BORDER, BOTTOM_HEIGHT)];
        bottom.backgroundColor = CXColorP(80, 80, 80, 0.9);
        [self addSubview:bottom];
        self.bottomView = bottom;
        
        UIView *scrollBottom = [[UIView alloc] init];
        scrollBottom.backgroundColor = CXColor(0, 230, 0);
        scrollBottom.layer.cornerRadius = 2;
        scrollBottom.layer.masksToBounds = YES;
        [self addSubview:scrollBottom];
        self.bottomScrollView = scrollBottom;
        
        UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, CGH(self)-BOTTOM_BAR_HEIGHT, CGW(self), BOTTOM_BAR_HEIGHT)];
        self.bar = bar;
        [self createBar];
        [self addSubview:bar];
        
        
//        bar.backgroundColor = CXColorP(200, 0, 0, 0.6);
        
    }
    return self;
}
// 创建三张imageView 用于滚动复用 占用内存小 当前和旁边的两张图片采用预加载
- (void)addThreeImageView
{
//    for (UIView *view in self.cycleScrollView.subviews) {
//        [view removeFromSuperview];
//    }
    // 创建三张imageView 设置位置
    for (int i = 0; i < 3; i++) {
        CGFloat W = CGW(self.cycleScrollView);
        CGFloat H = CGH(self.cycleScrollView);
        CXImageDescView *imageView = [[CXImageDescView alloc] initWithFrame:CGRectMake((i) * W , 0, W, H)];
//        imageView.backgroundColor = [UIColor redColor];
        // frame放在5个中间
//        imageView.frame = CGRectMake((i) * W , 0, W, H);
        // 放置中间
//        imageView.center = self.cycleScrollView.center;
        // 添加手势
        imageView.userInteractionEnabled = YES;
        [self.cycleScrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    // 将中间视图放到最上层
    [self.cycleScrollView bringSubviewToFront:self.imageViews[1]];
}

// 设置数据源(默认是网上解析后的imageurl字符串数组)
- (void)setImageUrlNames:(NSArray *)ImageUrlNames index:(NSIndexPath *)index
{
    self.currentPageIndex = index.row;
    
    [self.imageUrls removeAllObjects];
//    for (NSString *name in ImageUrlNames) {
//        [self.imageUrls addObject:[NSURL URLWithString:name]];
//    }
    [self.imageUrls addObjectsFromArray:ImageUrlNames];
    [self refreshImage];
    // 数据源设置page
    [self setupPage];
    
    self.cycleScrollView.userInteractionEnabled = YES;
}
// 初始化page
- (void)setupPage
{
    CGFloat pageW = (CGW(self)-2*INTERVAL_CELL_BORDER)/self.imageUrls.count;
    CGFloat pageH = BOTTOM_HEIGHT;
    CGFloat pageX = INTERVAL_CELL_BORDER+self.currentPageIndex*pageW;
    CGFloat pageY = CGRectGetMinY(self.bottomView.frame);
    self.bottomScrollView.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

// 设置数据源 和 自动滚动时间
- (void)setImageUrlNames:(NSArray *)ImageUrlNames index:(NSIndexPath *)index animationDuration:(NSTimeInterval)animationDuration
{
    // 创建定时器
    [self createTime:animationDuration];
    // 设置数据源
    [self setImageUrlNames:ImageUrlNames index:index];
}
// 创建定时器
- (void)createTime:(NSTimeInterval)animationDuration
{
    if (self.time) {
        return;
    }
    self.time = [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(timing) userInfo:nil repeats:YES];
    [self startTimeWithDelay:2];
    [[NSRunLoop mainRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
}
// 定时方法
- (void)timing
{
    CGPoint newOffset = CGPointMake(self.cycleScrollView.contentOffset.x + CGRectGetWidth(self.cycleScrollView.frame), self.cycleScrollView.contentOffset.y);
    [self.cycleScrollView setContentOffset:newOffset animated:YES];
}
// 暂停定时器
- (void)pauseTime
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate distantFuture];
        }
    }
}
// 开始定时器
- (void)startTime
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate distantPast];
        }
    }
}
// 一段时间后开始定时器
- (void)startTimeWithDelay:(NSTimeInterval)delay
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate dateWithTimeIntervalSinceNow:delay];
        }
    }
}

- (void)endTime
{
    if (self.time) {
        
        [self.time invalidate];
        self.time = nil;
    }
}

- (void)refreshImage
{
    if (self.imageUrls.count > 0) {
        [self refreshContentImageUrls];
        [self refreshImageView];
        [self setComAndZhan];
    }
}

// 刷新所有
- (void)refresh
{
    if (self.imageUrls.count > 0) {
        [self refreshImage];
        [self refreshLocation];
        [self refreshPage];
        
    }
    
}
// 刷新page的当前页
- (void)refreshPage
{
//    self.scrollPage.currentPage = self.currentPageIndex;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.bottomScrollView.frame;
        rect.origin.x = self.currentPageIndex * rect.size.width+INTERVAL_CELL_BORDER;
        self.bottomScrollView.frame = rect;
    }];
}
// 刷新内容数据源
- (void)refreshContentImageUrls
{
    long prePage = self.currentPageIndex - 1 >= 0 ? self.currentPageIndex - 1 : self.imageUrls.count - 1;
    long nextPage = self.currentPageIndex + 1 < self.imageUrls.count ? self.currentPageIndex + 1 : 0;
    
    [self.contentImageUrls removeAllObjects];
    [self.contentImageUrls addObject:self.imageUrls[prePage]];
    [self.contentImageUrls addObject:self.imageUrls[self.currentPageIndex]];
    [self.contentImageUrls addObject:self.imageUrls[nextPage]];
    
}
// 刷新imageView的图片 使用sdwebimage第三方加载图片
- (void)refreshImageView
{
    // 停止定时器
    [self pauseTime];
    CXScrollViewBarBtn *btn = self.barBtnArr[4];
//    btn.userInteractionEnabled = NO;
    btn.isLoading = YES;
    
    CXImageDescView *imageView1 = self.imageViews[1];
    CXImageDescView *imageView2 = self.imageViews[2];
    CXImageDescView *imageView0 = self.imageViews[0];
    
    // 加载第当前图片
//    [imageView1 setModel:self.contentImageUrls[1] isLoadImage:YES];
//     [imageView2 setModel:self.contentImageUrls[2] isLoadImage:NO];
//     [imageView0 setModel:self.contentImageUrls[0] isLoadImage:NO];
//    imageView1.model = self.contentImageUrls[1];
//    imageView2.model = self.contentImageUrls[2];
//    imageView0.model = self.contentImageUrls[0];
    // 随着库代码更改 需要更改下面代码
    [imageView1 setModel:self.contentImageUrls[1] isLoadImage:YES success:^{
            [self startTimeWithDelay:5];
        CXScrollViewBarBtn *btn = self.barBtnArr[4];
        
//        btn.userInteractionEnabled = YES;
        btn.isLoading = NO;
        
        [imageView2 setModel:self.contentImageUrls[2] isLoadImage:YES success:^{
            [self startTimeWithDelay:START_ANIMATION];
            
        }];
        [imageView0 setModel:self.contentImageUrls[0] isLoadImage:YES];
    }];
    
}
// 刷新位置
- (void)refreshLocation
{
    self.cycleScrollView.contentOffset = CGPointMake((int)((IMAGEVIEW_COUNT)/2)*CGRectGetWidth(self.cycleScrollView.frame), self.cycleScrollView.contentOffset.y);
}


#pragma mark - 监听scroll
// 滚动动画结束时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimeWithDelay:STARTTIME_DELAY];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTime];
}
// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == (IMAGEVIEW_COUNT - 3) * CGRectGetWidth(self.cycleScrollView.frame)) {
        self.currentPageIndex = self.currentPageIndex - 1 >= 0 ? self.currentPageIndex - 1 : self.imageUrls.count - 1;
        [self refresh];
        
    } else if (scrollView.contentOffset.x == (IMAGEVIEW_COUNT-1) * CGRectGetWidth(self.cycleScrollView.frame)) {
        self.currentPageIndex = self.currentPageIndex + 1 < self.imageUrls.count ? self.currentPageIndex + 1 : 0;
        [self refresh];
    }
}

#pragma mark - bar的创建
- (void)createBar
{
    NSArray *imageUrl = @[@"icon_like_white_32", @"icon_comment_white_32", @"icon_cloud_white_32", @"icon_share_line_white_40", @"icon_edit_white_32"];
    NSArray *disImageUrl = @[@"", @"", @"", @"", @"icon_edit_gray_32"];
    NSArray *selImageUrl = @[@"icon_like_32_red", @"", @"icon_cloud_stop_line_32_blue", @"", @"icon_edit_blue_32"];
    NSArray *titles = @[@"赞", @"评论", @"自动播放", @"进入游记", @"保存图片"];
    NSArray *selTitle = @[@"赞", @"评论", @"停止播放", @"进入游记", @"已保存"];
    for (int i = 0; i < titles.count; i++) {
        CGFloat W = (CGW(self.cycleScrollView)-2*INTERVAL_CELL_BORDER)/titles.count;
        CGFloat H = BOTTOM_BAR_HEIGHT;
        CGFloat X = INTERVAL_CELL_BORDER + i*W;
        CGFloat Y = 0;
        CXScrollViewBarBtn *btn = [[CXScrollViewBarBtn alloc] initWithFrame:CGRectMake(X, Y, W, H)];
        [btn setImage:[UIImage imageNamed:imageUrl[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selImageUrl[i]] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:disImageUrl[i]] forState:UIControlStateDisabled];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitle:selTitle[i] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(barBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.barBtnArr addObject:btn];
        btn.tag = i+BARBTN_TAG;
        [self.bar addSubview:btn];
    }
}



- (void)barBtnClick:(CXScrollViewBarBtn *)btn
{
    switch (btn.tag-BARBTN_TAG) {
        case 0:
            [self zhan:btn];
            break;
        case 1:
            [self comment:btn];
            break;
        case 2:
            [self playVideo:btn];
            break;
        case 3:
            [self gotoTrip:btn];
            break;
        case 4:
            [self save:btn];
            break;
            
        default:
            break;
    }
}

- (void)zhan:(CXScrollViewBarBtn *)btn
{
//    btn.selected = !btn.selected;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"submit"] = @"addLike";
//    dict[@"itemtype"] = @"1";
//    dict[@"isadd"] = @"1";
//    dict[@"v"] = @"a6.1.0";
//    dict[@"vc"] = @"anzhuo";
//    dict[@"vd"] = @"f7393db54aeaedec";
//    dict[@"token"] = @"27f3f6568d2faf418538f66d72330a23";
//    
//    [RequestTool POST:@"http://app6.117go.com/demo27/php/formAction.php" parameters:dict success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *str = [user objectForKey:@"isLogin"];
//    if (str.length == 0) {
//        
//    }
    
}

- (void)comment:(CXScrollViewBarBtn *)btn
{
    CXCollectViewCellModel *model = self.imageUrls[self.currentPageIndex];
    CXCollectionVCellModel *cellmodel = model.pic;
    if ([self.delegate respondsToSelector:@selector(scrollViweBarCmtButtenClick:)]) {
        [self.delegate scrollViweBarCmtButtenClick:cellmodel];
    }
}
- (void)playVideo:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [self createTime:START_ANIMATION];
    } else {
        [self endTime];
    }
    
}
- (void)gotoTrip:(CXScrollViewBarBtn *)btn
{

}
- (void)save:(CXScrollViewBarBtn *)btn
{
    if (btn.selected) {
        [MBProgressHUD showSuccess:@"已经保存"];
        return;
    }
    if (btn.isLoading == YES) {
        [MBProgressHUD showError:@"正在加载"];
        return;
    }
    CXImageDescView *imageView1 = self.imageViews[1];
    UIImage *image = imageView1.imageView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = nil;
    if (error) {
        message = [error description];
        [MBProgressHUD showError:message];
        return;
    }
    message = @"保存成功";
    [MBProgressHUD showSuccess:message];
    
    [self.barBtnArr[4] setSelected:YES];
}

- (void)setComAndZhan
{
    [self.barBtnArr[4] setSelected:NO];
    CXCollectViewCellModel *model = self.imageUrls[self.currentPageIndex];
    CXCollectionVCellModel *cellmodel = model.pic;
    NSString *like = [cellmodel.likeCnt isEqualToString:@"0"]?@"赞":cellmodel.likeCnt;
    NSString *cmt = [cellmodel.cntcmt isEqualToString:@"0"]?@"评论":cellmodel.cntcmt;
    [self.barBtnArr[0] setTitle:like forState:UIControlStateNormal];
    [self.barBtnArr[1] setTitle:cmt forState:UIControlStateNormal];
}

@end
