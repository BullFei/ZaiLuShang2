//
//  ZYCAttentionModel.h
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "TieShiModel.h"

typedef NS_ENUM(NSInteger, TSCellType)
{
    TSCellTypePictureNone =0,
    TSCellTypePictureOne,
    TSCellTypePictureMutible
};
@interface ZYCAttentionModel : NSObject
//cell的高度
@property (nonatomic,assign)CGFloat cellHeight;

//cell的种类
@property (nonatomic,assign)TSCellType cellType;

//cell的model
@property (nonatomic,weak)TieShiModel * tsm;

/*第一部分**/


//作者
@property (nonatomic,assign)CGRect authorButtonFrame;
//作者昵称
@property (nonatomic,assign)CGRect nickNameFrame;
//更新时间
@property (nonatomic,assign)CGRect timeFrame;

/***第二部分**/

//标签父视图容器
@property (nonatomic,assign)CGRect tagsFrame;
//标签个数
@property (nonatomic,assign)NSInteger tagCount;
//标签内部间距
@property (nonatomic,assign)CGFloat tagsSpace;
//标签Size
@property (nonatomic,assign)CGSize tagSize;

/***第三部分**/

//文字说明部分
@property (nonatomic,assign)CGRect wordsFrame;

/**第四部分**/

//图片1张
@property (nonatomic,assign)CGRect OnePicFrame;
//九宫格（多张）图片
@property (nonatomic,assign)CGRect picsFrame;//容器
//图片个数
@property (nonatomic,assign)NSInteger picCount;
//图片内部间距
@property (nonatomic,assign)CGFloat picsSpace;
//图片Size
@property (nonatomic,assign)CGSize picSize;

/***第五部分**/

//赞按钮
@property (nonatomic,assign)CGRect zanButtonFrame;
@property (nonatomic,assign)CGRect commentButtonFrame;
/*给哥一个模型，还你一个布局**/
-(instancetype)initWithModel:(TieShiModel *)tsm;
@end














