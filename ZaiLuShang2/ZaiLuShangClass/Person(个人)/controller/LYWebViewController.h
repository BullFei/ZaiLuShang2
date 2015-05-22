//
//  LYWebViewController.h
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, webPageType) {
    WebViewPageTypeUser = 0,
    WebViewPageTypeTour
};

@interface LYWebViewController : UIViewController

@property (nonatomic, copy) NSString *tourid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, assign) webPageType pageType;

@end
