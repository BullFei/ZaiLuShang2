//
//  CXImageDescView.m
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CXImageDescView.h"
#import "SFImageView.h"
#import "UIImageView+WebCache.h"
#import "CXCollectViewCellModel.h"
#import "CXCollectionVCellModel.h"
#import "CXCollectionVCellOwnerModel.h"


#define BILI 0.8
#define ICONIMAGEVIEW_WIDTH 50
#define ICONIMAGEVIEW_INTERVAL 20
@interface CXImageDescView ()

@property (nonatomic ,weak) UIImageView *userImageView;
@property (nonatomic ,weak) UILabel *titleLabel;
@property (nonatomic ,weak) UILabel *userLabel;
@end

@implementation CXImageDescView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = width/BILI;
        SFImageView *imageView = [[SFImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-height)/2, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.center = self.center;
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor clearColor];
        // 手势
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [imageView addGestureRecognizer:pinch];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [imageView addGestureRecognizer:pan];
        
        self.imageView = imageView;
        [self addSubview:imageView];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(INTERVAL_CELL_BORDER, CGH(self) - ICONIMAGEVIEW_WIDTH - ICONIMAGEVIEW_INTERVAL,ICONIMAGEVIEW_WIDTH, ICONIMAGEVIEW_WIDTH)];
        iconView.layer.cornerRadius = ICONIMAGEVIEW_WIDTH/2;
        iconView.layer.masksToBounds = YES;
        [self addSubview:iconView];
        self.userImageView = iconView;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImageView.frame) + INTERVAL_CELL_CELL, CGRectGetMinY(self.userImageView.frame), CGW(self) - CGRectGetMaxX(self.userImageView.frame)-INTERVAL_CELL_CELL*2, 20)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        self.titleLabel = label;
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.userImageView.frame) - 20, CGW(self.titleLabel), 20)];
        userLabel.textColor = [UIColor whiteColor];
        userLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:userLabel];
        self.userLabel = userLabel;
        
        
        
    }
    return self;
}
//  拖拽手势
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
   
    CGPoint point = [pan translationInView:pan.view.superview];
//     NSLog(@"%f, %f", point.x, point.y);
    pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view.superview];
}

- (void)setUpLocation
{
    CGFloat width = CGW(self);
    CGFloat height = width/BILI;
    self.imageView.frame = CGRectMake(0, (CGH(self)-height)/2, width, height);
}

- (void)setModel:(CXCollectViewCellModel *)model isLoadImage:(BOOL)is
{
    [self setModel:model isLoadImage:is success:nil];
}

- (void)setModel:(CXCollectViewCellModel *)model isLoadImage:(BOOL)is success:(void (^)())success
{
    
    
    _model = model;
    // 模型
    CXCollectionVCellModel *cellmodel = model.pic;
    CXCollectionVCellOwnerModel *owner = cellmodel.owner;
    // 图片
    NSString *str = [NSString stringWithFormat:@"%@f1400/%@", cellmodel.picdomain, cellmodel.picfile];
    if (is) {
        [self setUpLocation];
        [self.imageView setImageWithUrl:str withPlaceHolderImage:@"" success:^{
            if (success){
                success();
            }
        }];
    }
    // 用户头像
    NSString *user = [NSString stringWithFormat:@"%@ava102/%@", owner.picdomain, owner.avatar];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user] placeholderImage:[UIImage imageNamed:@"switch_handle"]];
    // 文字
    self.titleLabel.text = cellmodel.tourtitle;
    self.userLabel.text = [NSString stringWithFormat:@"by %@", owner.nickname];
    
}

@end
