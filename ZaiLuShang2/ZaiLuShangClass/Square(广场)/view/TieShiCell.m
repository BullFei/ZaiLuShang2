//
//  TieShiCell.m
//  ZaiLuShang2
//
//  Created by 张怡晨 on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TieShiCell.h"

#import "Header.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

#import "ZYCTagsModel.h"
#import "PictureModel.h"
@implementation TieShiCell
{
    NSMutableArray * _tagLabelsArray;
    NSMutableArray * _picsImageViewArray;
}
- (void)awakeFromNib {
    // Initialization code
}

//复用没写好，初始错开才行
+(TieShiCell *)getTieShiCellWithTableView:(UITableView *)tableView attetionModel:(ZYCAttentionModel *)attM
{
    TieShiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"TieShiCell"];
    if (cell ==nil) {
        
        cell =[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TieShiCell"];
        
    }
    [cell configCellWithAttentionModel:attM];
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return  self;
}
//不复用
+(TieShiCell *)getTieShiCellWithZYCAttention:(ZYCAttentionModel *)attM
{
    return  [[self alloc]initWithZYCAttention:attM];
}

- (instancetype)initWithZYCAttention:(ZYCAttentionModel *)attM {
    if (self = [super init]) {
        [self initArray];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configCellWithAttentionModel:attM];
    }
    return self;
}

-(void)setTsm:(TieShiModel *)tsm
{
    _tsm =tsm;
    //作者
    NSString * authorUrl =[NSString stringWithFormat:@"%@%@%@",_tsm.user.picdomain,SMALL_HEAD,tsm.user.avatar];
    [_authorButton sd_setBackgroundImageWithURL:[NSURL URLWithString:authorUrl] forState:UIControlStateNormal];
    _nicknameLabel.text =_tsm.user.nickname;
    
    _timeLabel.text =_tsm.lastupdate;
        //tags
    for (int i=0; i<_tsm.tags.count; i++) {
        UILabel * tagLabel =[_tagLabelsArray objectAtIndex:i];
        ZYCTagsModel * tm =[_tagsModelArray objectAtIndex:i];
        
        tagLabel.text = tm.name;
        
    }
    //words
    _wordsLabel.text =_tsm.words;
    
    //图片
    if (![_tsm.pic isEqualToString:@""]) {
        NSString * imageurl =[NSString stringWithFormat:@"%@%@%@",_tsm.picdomain,BIG_IMAGE,_tsm.pic];
        [_oneImageView sd_setImageWithURL:[NSURL URLWithString:imageurl]];
        
    }
    if (_tsm.pics!=nil&&_tsm.pics.count>1) {
        for (int i =0; i<_tsm.pics.count; i++) {
            PictureModel * pm =[_pictureModelArray objectAtIndex:i];
            UIImageView * iv =[_picsImageViewArray objectAtIndex:i];
            NSString * imageurl =[NSString stringWithFormat:@"%@%@%@",pm.picdomain,SMALL_IMAGE,pm.picfile];
            [iv sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"bg_pic_placeholder_small.9"]];
        }
    }
    //底部的button
    // 将图片处理为缩小版
    UIImage *likeImage;
    NSData *likeData;
    if (_tsm.isLiked == NO) {
        likeImage = [UIImage imageNamed:@"icon_like_line_red_24"];
        likeData = UIImagePNGRepresentation(likeImage);
        likeImage = [UIImage imageWithData:likeData scale:2];
    } else {
        likeImage = [UIImage imageNamed:@"icon_like_32_red"];
        likeData = UIImagePNGRepresentation(likeImage);
        likeImage = [UIImage imageWithData:likeData scale:2];
    }
    
    if (_tsm.cntzan.intValue == 0) {
        self.zanButton.imageView.contentMode = UIViewContentModeCenter;
    } else {
        [self.zanButton setTitle:_tsm.cntzan forState:UIControlStateNormal];
    }
    [self.zanButton setImage:likeImage forState:UIControlStateNormal];
    //[self.contentView addSubview:self.zanButton];
   // [self.likeButton addTarget:self action:@selector(loveyou:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *cmtImage = [UIImage imageNamed:@"icon_comment_line_blue_24"];
    NSData *cmtData = UIImagePNGRepresentation(cmtImage);
    cmtImage = [UIImage imageWithData:cmtData scale:2];
    
    if (_tsm.cntcmt.integerValue == 0) {
        self.commentButton.imageView.contentMode = UIViewContentModeCenter;
    } else {
        [self.commentButton setTitle:_tsm.cntcmt forState:UIControlStateNormal];
    }
    [self.commentButton setImage:cmtImage forState:UIControlStateNormal];
    //[self.contentView addSubview:self.commentButton];
    // 评论按钮事件
    //[self.commentButton addTarget:self action:@selector(readMoreComments) forControlEvents:UIControlEventTouchUpInside];

    
}
               
               
//-(instancetype)initWithStyle:(UITableViewCellStyle )style reuseIdentifier:(NSString *)reuseIdentifier attetionModel:(ZYCAttentionModel *)attM
//{
//    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self initArray];
//        [self configCellWithAttentionModel:attM];
//            
//            
//    }
//        return  self;
//}


    
-(void)initArray
{
    if (_tagLabelsArray==nil) {
        _tagLabelsArray =[[NSMutableArray alloc]init];
    }
    if (_picsImageViewArray==nil) {
        _picsImageViewArray =[[NSMutableArray alloc]init];
    }
}
-(void)configCellWithAttentionModel:(ZYCAttentionModel *)attM
{
    //作者button
    self.authorButton =[[UIButton alloc]init];
    self.authorButton.frame = attM.authorButtonFrame;
    self.authorButton.layer.cornerRadius =self.authorButton.frame.size.width/2;
    self.authorButton.layer.masksToBounds =YES;
    [self.contentView addSubview:self.authorButton];
    //作者昵称
    self.nicknameLabel =[[UILabel alloc]init];
    self.nicknameLabel.frame =attM.nickNameFrame;
    self.nicknameLabel.font = TextFont_15;
    [self.contentView addSubview:self.nicknameLabel];
    //作者时间
    self.timeLabel =[[UILabel alloc]init];
    self.timeLabel.frame =attM.timeFrame;
    self.timeLabel.font = TextFont_15;
    [self.contentView addSubview:self.timeLabel];
    //tags
    self.tagsView =[[UIView alloc]init];
    self.tagsView.frame =attM.tagsFrame;
    [self.contentView addSubview:self.tagsView];
    for (int i= 0; i<attM.tagCount; i++) {
        UILabel * tagLabel =[[UILabel alloc]initWithFrame:CGRectMake(i*(attM.tagSize.width+attM.tagsSpace), 0, attM.tagSize.width,attM.tagSize.height)];
        tagLabel.textAlignment =NSTextAlignmentCenter;
        tagLabel.font =[UIFont systemFontOfSize:13*SCREEN_WIDTH/320];
        tagLabel.backgroundColor=[UIColor lightGrayColor];
        //tagLabel.backgroundColor =CXColor(arc4random()%256, arc4random()%256, arc4random()%256);
        //tagLabel.tintColor =CXColor(arc4random()%256, arc4random()%256, arc4random()%256);
        tagLabel.layer.cornerRadius =5;
        tagLabel.layer.masksToBounds =YES;
        [self.tagsView addSubview:tagLabel];
        [_tagLabelsArray addObject:tagLabel];
        
    }
    //文字说明
    self.wordsLabel =[[UILabel alloc]initWithFrame:attM.wordsFrame];
    self.wordsLabel.numberOfLines =5;
    self.wordsLabel.font =TextFont_15;
    [self.contentView addSubview:_wordsLabel];
    //图片部分
    if (attM.cellType==TSCellTypePictureOne) {
        _oneImageView =[[UIImageView alloc]initWithFrame:attM.OnePicFrame];
        [self.contentView addSubview:_oneImageView];
        
        
    }
    else if(attM.cellType ==TSCellTypePictureMutible)
    {
        _picsView =[[UIView alloc]initWithFrame:attM.picsFrame];
        [self.contentView addSubview:_picsView];
        for (int i=0; i<(attM.picCount+2)/3; i++) {
            for (int j =0; j<3; j++) {
                UIImageView * iv =[[UIImageView alloc]initWithFrame:CGRectMake(j*(attM.picSize.width+attM.picsSpace),i*(attM.picSize.height+attM.picsSpace) ,attM.picSize.width , attM.picSize.height)];
                [self.picsView addSubview:iv];
                [_picsImageViewArray addObject:iv];
            }
           
        }
    }
        
        
    
    //底部Button
    _zanButton =[[UIButton alloc]initWithFrame:attM.zanButtonFrame];
    [self.contentView addSubview:_zanButton];
    [_zanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _commentButton =[[UIButton alloc]initWithFrame:attM.commentButtonFrame];
    [self.contentView addSubview:_commentButton];
    [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _cellHeight = attM.cellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
