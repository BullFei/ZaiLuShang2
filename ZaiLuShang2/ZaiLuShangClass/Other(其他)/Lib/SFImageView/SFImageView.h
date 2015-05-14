//
//  SFImageView.h
//  SFLoadImage
//
//  Created by qianfeng on 15/5/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SFImageView : UIImageView

-(void)setImageWithUrl:(NSURL *)url;


-(void)setImageWithUrl:(NSString *)url withPlaceHolderImage:(NSString *)placeHolder;

-(void)setImageWithUrl:(NSString *)url withPlaceHolderImage:(NSString *)placeHolder  success:(void (^)())success;

@end
