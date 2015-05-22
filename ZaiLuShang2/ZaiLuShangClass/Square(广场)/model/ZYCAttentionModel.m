//
//  ZYCAttentionModel.m
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZYCAttentionModel.h"
#define  ZYC_TSCELL_HORISONSPACE 8*SCREEN_WIDTH/320
#define  ZYC_TSCELL_VERTICALSPACE 8*SCREEN_WIDTH/320
#define  ZYC_TSCELL_NINESQUARESPACE 5*SCREEN_WIDTH/320

#import "ZYCTagsModel.h"
#import "PictureModel.h"
#import "MJExtension.h"
@implementation ZYCAttentionModel
-(instancetype)initWithModel:(TieShiModel *)tsm
{
    if (self=[super init]) {
        [self configFrameWithModel:tsm];
    }
    return self;
}
//-(void)setTsm:(TieShiModel *)tsm
//{
//    _tsm=tsm;
//    NSArray * tagsArr =tsm.tags;
//    _tsm.tags = [ZYCTagsModel objectArrayWithKeyValuesArray:tagsArr];
//    NSArray * picsArr =tsm.pics;
//    _tsm.pics =[PictureModel objectArrayWithKeyValuesArray:picsArr];
//    
//    
//}

-(void)configFrameWithModel:(TieShiModel *)tsm
{
    self.tsm =tsm;
    //将tsm模型中的两个数组字典转化为模型字典，时间改成新格式时间
    
    //作者button
    CGFloat authorX = ZYC_TSCELL_HORISONSPACE;
    CGFloat authotY =ZYC_TSCELL_VERTICALSPACE;
    CGFloat authorW =SCREEN_WIDTH/6;
    CGFloat authorH =SCREEN_WIDTH/6;
    self.authorButtonFrame =CGRectMake(authorX, authotY,authorW , authorH);
    //nickname
    CGFloat nicknameX =authorX+authorW+ZYC_TSCELL_HORISONSPACE;
    CGFloat nicknameY =authotY;
    CGFloat nicknameW =[tsm.user.nickname sizeWithAttributes:@{NSFontAttributeName : TextFont_15}].width;
    CGFloat nicknameH =(authorH-ZYC_TSCELL_VERTICALSPACE)/2;
    self.nickNameFrame =CGRectMake(nicknameX, nicknameY, nicknameW, nicknameH);
    //时间
    CGFloat timeX = nicknameX;
    CGFloat timeY =nicknameY+nicknameH+ZYC_TSCELL_VERTICALSPACE;
    CGFloat timeW =[tsm.lastupdate sizeWithAttributes:@{NSFontAttributeName : TextFont_15}].width ;
    CGFloat timeH = nicknameH;
    self.timeFrame =CGRectMake(timeX, timeY, timeW, timeH);
    
    //tags
    CGFloat tagsX = authorX;
    CGFloat tagsY = authotY+authorH+ZYC_TSCELL_VERTICALSPACE;
    CGFloat tagsW =SCREEN_WIDTH - 3* ZYC_TSCELL_HORISONSPACE;
    CGFloat tagsH =authorH/2;
    self.tagsFrame = CGRectMake(tagsX, tagsY, tagsW, tagsH);
    self.tagCount  = tsm.tags.count;
    self.tagsSpace =ZYC_TSCELL_HORISONSPACE;
    self.tagSize = CGSizeMake(authorW, tagsH);
    
    //words
    CGFloat wordsX =authorX;
    CGFloat wordsY =tagsY+tagsH+ZYC_TSCELL_VERTICALSPACE;
    CGFloat wordsW =SCREEN_WIDTH -3* ZYC_TSCELL_HORISONSPACE;
    CGSize ss  =[tsm.words boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 3*ZYC_TSCELL_HORISONSPACE , 120) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:TextFont_15 forKey:NSFontAttributeName] context:nil].size;
    CGFloat wordsH =ss.height;
    self.wordsFrame =CGRectMake( wordsX, wordsY, wordsW, wordsH);
    
    //one
    CGFloat onepicX =authorX;
    CGFloat onepicY =wordsY+wordsH+ZYC_TSCELL_VERTICALSPACE;
   // CGFloat onepicW =(1-arc4random()%25/100)*SCREEN_WIDTH;
    CGFloat onepicW =SCREEN_WIDTH *0.75;
    CGFloat picw =[tsm.picw floatValue];
    CGFloat pich =[tsm.pich floatValue];
    
    CGFloat onepicH =onepicW*pich/picw;
    self.OnePicFrame =CGRectMake(onepicX, onepicY, onepicW, onepicH);
    
    //duoge
    CGFloat mutpicsX = onepicX;
    CGFloat mutpicsY =onepicY;
    CGFloat mutpicsW =SCREEN_WIDTH-2*ZYC_TSCELL_HORISONSPACE;
    
    
    self.picCount =tsm.pics.count;
    

    self.picsSpace =ZYC_TSCELL_NINESQUARESPACE;
    
    CGFloat pic =(mutpicsW-2*self.picsSpace)/3;
    self.picSize =CGSizeMake(pic, pic);
    
    NSInteger lines =(self.picCount+2)/3;
    CGFloat mutpicsH = lines * pic+(lines-1)*self.picsSpace;
    self.picsFrame =CGRectMake(mutpicsX, mutpicsY, mutpicsW, mutpicsH);
    
    //zan 和comment
    CGFloat zanX =authorX;
    CGFloat zanY;
    CGFloat zanW =authorW+ZYC_TSCELL_HORISONSPACE;
    CGFloat zanH =tagsH;

    if ([tsm.pic isEqualToString:@""]) {
        //无图
        self.cellType =TSCellTypePictureNone;
       
         zanY =onepicY;//one yu mut 一样
        
        
        
    }else if(tsm.pics.count==1)
    {
        self.cellType =TSCellTypePictureOne;
        zanY = onepicY+onepicH+ZYC_TSCELL_VERTICALSPACE;
    }else
    {
        self.cellType =TSCellTypePictureMutible;
        zanY =mutpicsY+mutpicsH+ZYC_TSCELL_VERTICALSPACE;
    }
    self.zanButtonFrame =CGRectMake(zanX, zanY, zanW, zanH);
    
    
    
    CGFloat commentX =zanX+zanW+ZYC_TSCELL_HORISONSPACE;
    CGFloat commentY =zanY;
    CGFloat commentW =zanW;
    CGFloat commentH =zanH;
    self.commentButtonFrame =CGRectMake(commentX, commentY, commentW,commentH);
    self.cellHeight =zanY+zanH+ZYC_TSCELL_VERTICALSPACE;
}
@end











