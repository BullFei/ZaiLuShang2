//
//  CXCmtModel.h
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXCollectionVCellOwnerModel;

@interface CXCmtModel : NSObject

@property (nonatomic, copy) NSString *cmtid;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *replycmtid;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic ,strong) CXCollectionVCellOwnerModel *user;

@end
