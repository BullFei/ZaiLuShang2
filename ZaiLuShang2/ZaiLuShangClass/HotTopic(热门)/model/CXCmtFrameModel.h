//
//  CXCmtFrameModel.h
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXCmtModel;

#define TEXT_FONT 14
#define NAME_FONT 15
#define TIME_FONT 12

#define IMAGEVIEW_BORDER 10
#define NAME_IMAGEVIEW 8
@interface CXCmtFrameModel : NSObject

@property (nonatomic ,strong) CXCmtModel *cmtModel;

@property (nonatomic, assign) CGRect imageViewF;

@property (nonatomic, assign) CGRect nickNameF;
@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect textLabelF;

@property (nonatomic, assign) CGFloat cellH;

@end
