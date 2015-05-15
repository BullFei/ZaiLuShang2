//
//  SFStickerCell.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCityTypeHead,SFSceneryObjModel,SFStickerCell;
@protocol SFStickerCellDelegate <NSObject>

-(void)stickerCell:(SFStickerCell *)stickerCell withID:(NSInteger)locid withSign:(NSString *)sign;

@end


@interface SFStickerCell : UITableViewCell

@property (nonatomic,strong) SFCityTypeHead * cityTypeHead;
@property (nonatomic,strong) SFSceneryObjModel * sceneryObjModel;
@property (nonatomic,assign)id<SFStickerCellDelegate>delegate;
+(SFStickerCell *)cellWithTableView:(UITableView *)tableView;
@end
