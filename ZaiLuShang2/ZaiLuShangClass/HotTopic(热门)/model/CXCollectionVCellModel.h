//
//  CXCollectionVCellModel.h
//  ZaiLuShang
//
//  Created by gaocaixin on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXCollectionVCellOwnerModel.h"

@interface CXCollectionVCellModel : NSObject


@property (nonatomic, copy) NSString *picid;
@property (nonatomic, copy) NSString *tourid;
@property (nonatomic, copy) NSString *userid;

@property (nonatomic, strong) CXCollectionVCellOwnerModel *owner;

@property (nonatomic, copy) NSString *picdomain;
@property (nonatomic, copy) NSString *picfile;

@property (nonatomic, copy) NSString *pcolor;

@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *tourtitle;

@end
