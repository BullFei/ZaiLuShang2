//
//  SFImageView.m
//  SFLoadImage
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFImageView.h"
#import "UIImageView+WebCache.h"
#define SCALE 0.4
#define IMAGEVIEW_BACKGROUND [UIColor lightGrayColor]

@interface SFImageView ()
@property (nonatomic ,weak) UIView *rotationView;
@property (nonatomic ,weak) UIView *bgVIew;
@property (nonatomic ,weak) UIView *proView;
@end

@implementation SFImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


-(void)setImageWithUrl:(NSString *)url
{
    [self setImageWithUrl:url withPlaceHolderImage:nil];
    
}

-(void)setImageWithUrl:(NSString *)url withPlaceHolderImage:(NSString *)placeHolder
{
    [self setImageWithUrl:url withPlaceHolderImage:placeHolder success:nil];
}

-(void)setImageWithUrl:(NSString *)url withPlaceHolderImage:(NSString *)placeHolder  success:(void (^)())success
{
    
    //    [self setUpLocation];
    if (self.rotationView) {
        [self.rotationView removeFromSuperview];
    }
    if (self.proView) {
        [self.proView removeFromSuperview];
    }
    if ( self.bgVIew) {
        [self.bgVIew removeFromSuperview];
    }
    
    CGFloat progressViewWidth =CGW(self)>CGH(self)?CGH(self)*0.3:CGW(self)*0.3;
    CGFloat progressViewHeight =progressViewWidth;
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake((CGW(self)-progressViewWidth)/2, (CGH(self)-progressViewHeight)/2, progressViewWidth, progressViewHeight)];
    //    view.backgroundColor = [UIColor redColor];
    view.image = [UIImage imageNamed:@"icon_loading"];
    
    self.rotationView = view;
    // 动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI*2];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    UIView *bgView = [self createView];
    progressViewWidth = progressViewWidth/2;
    progressViewHeight =progressViewWidth;
    bgView.frame = CGRectMake((CGW(self)-progressViewWidth)/2, (CGH(self)-progressViewHeight)/2, progressViewWidth, progressViewHeight);
    bgView.layer.cornerRadius = progressViewWidth/2;
    bgView.backgroundColor = CXColorP(100, 100, 100, 1);
    self.bgVIew = bgView;
    
    UIView *proView = [[UIView alloc] init];
    [bgView addSubview:proView];
    proView.backgroundColor = CXColorP(200, 200, 200, 1);
    self.proView = proView;
    
    // 最后添加view
    [self addSubview:view];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolder] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress =(CGFloat)receivedSize/(CGFloat)expectedSize;
        if (progress>0) {
            CGRect rect = self.bgVIew.bounds;
            CGFloat H = rect.size.height * progress;
            CGRect newRect = CGRectMake(0, rect.size.height-H, rect.size.width, H);
            self.proView.frame = newRect;
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.rotationView removeFromSuperview];
        [self.bgVIew removeFromSuperview];
        [self.proView removeFromSuperview];
        
        if (success) {
            success();
        }
    }];
}


- (UIView *)createView
{
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    
    bgView.layer.masksToBounds = YES;
    return bgView;
}

@end
