//
//  JingXuanCell.m
//  ZaiLuShang
//
//  Created by 张怡晨 on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JingXuanCell.h"
#import "UIImageView+WebCache.h"
#import "SFImageView.h"
#import "Header.h"
@interface  JingXuanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;


@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;

@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *pictureCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *tuLabel;

@property (weak, nonatomic) IBOutlet UIButton *authorButton;

@property (weak, nonatomic) IBOutlet UIScrollView *commentsScrollView;

@end
@implementation JingXuanCell
{
    NSInteger commentCount;
    BOOL isLoadData;
}


+(JingXuanCell *)GetJingXuanCellWithTableView:(UITableView *)tableview
{
    static NSString * cellId =@"jingxuan";
    JingXuanCell * cell =[tableview dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        UINib *nib =[UINib nibWithNibName:@"jingxuancell" bundle:nil];
        [tableview registerNib:nib forCellReuseIdentifier:cellId];
        NSArray * objs=[nib instantiateWithOwner:self options:nil];
        cell =objs.lastObject;
    }
    return cell;
    
}
//初始化
-(void)initCommentsScrollView
{
     commentCount =_CommentModelArray.count;
    _commentsScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, 56*(commentCount+2));
    _commentsScrollView.contentOffset =CGPointMake(0, 56);
    _commentsScrollView.pagingEnabled =YES;
    _commentsScrollView.scrollEnabled=NO;
    _commentsScrollView.bounces =NO;
    _commentsScrollView.showsVerticalScrollIndicator =NO;
    [self createCommentsViews];
    
}
-(void)createCommentsViews
{
    //第一个0
    {
        UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56)];
        view.userInteractionEnabled =YES;
        CommentModel * commentModel =_CommentModelArray.lastObject;
        UIImageView * userHeadView =[[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 30, 30)];
        userHeadView.layer.cornerRadius =15;
        userHeadView.layer.masksToBounds =YES;
        NSString * headURL =[NSString stringWithFormat:@"%@%s%@",commentModel.user.picdomain,SMALL_HEAD,commentModel.user.avatar];
        [userHeadView sd_setImageWithURL:[NSURL URLWithString:headURL]];
        [view addSubview:userHeadView];
        
        UILabel * userNameAndCommentLabel =[[UILabel alloc]initWithFrame:CGRectMake(56,0 , SCREEN_WIDTH-56-13, 56)];
        userNameAndCommentLabel.numberOfLines =2;
        userNameAndCommentLabel.font =TextFont_15;
        userNameAndCommentLabel.text =[NSString stringWithFormat:@"%@: %@",commentModel.user.nickname,commentModel.words];
        [view addSubview:userNameAndCommentLabel];
        
        UIControl * ctrl =[[UIControl alloc]initWithFrame:view.bounds];
        [ctrl addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ctrl];
        [_commentsScrollView addSubview:view];
        
    }
    
    for (int i=1; i<commentCount+1; i++) {
        UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 56*i, SCREEN_WIDTH, 56)];
        view.userInteractionEnabled =YES;
        
        CommentModel * commentModel =[_CommentModelArray objectAtIndex:i-1];
        //ReviewerModel * reviewerModel =commentModel.user;
        
        UIImageView * userHeadView =[[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 30, 30)];
        userHeadView.layer.cornerRadius =15;
        userHeadView.layer.masksToBounds =YES;
        NSString * headURL =[NSString stringWithFormat:@"%@%s%@",commentModel.user.picdomain,SMALL_HEAD,commentModel.user.avatar];
        [userHeadView sd_setImageWithURL:[NSURL URLWithString:headURL]];
        [view addSubview:userHeadView];
        
        UILabel * userNameAndCommentLabel =[[UILabel alloc]initWithFrame:CGRectMake(56,0 , SCREEN_WIDTH-56-13, 56)];
        userNameAndCommentLabel.numberOfLines =2;
        userNameAndCommentLabel.font =TextFont_15;
        userNameAndCommentLabel.text =[NSString stringWithFormat:@"%@: %@",commentModel.user.nickname,commentModel.words];
        [view addSubview:userNameAndCommentLabel];
        
        UIControl * ctrl =[[UIControl alloc]initWithFrame:view.bounds];
        [ctrl addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ctrl];
        [_commentsScrollView addSubview:view];
    }//最好把数据也加上
    {
        UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, (commentCount+1)*56, SCREEN_WIDTH, 56)];
        view.userInteractionEnabled =YES;
        CommentModel * commentModel =_CommentModelArray.firstObject;
        UIImageView * userHeadView =[[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 30, 30)];
        userHeadView.layer.cornerRadius =15;
        userHeadView.layer.masksToBounds =YES;
        NSString * headURL =[NSString stringWithFormat:@"%@%s%@",commentModel.user.picdomain,SMALL_HEAD,commentModel.user.avatar];
        [userHeadView sd_setImageWithURL:[NSURL URLWithString:headURL]];
        [view addSubview:userHeadView];
        
        UILabel * userNameAndCommentLabel =[[UILabel alloc]initWithFrame:CGRectMake(56,0 , SCREEN_WIDTH-56-13, 56)];
        userNameAndCommentLabel.numberOfLines =2;
        userNameAndCommentLabel.font =TextFont_15;
        userNameAndCommentLabel.text =[NSString stringWithFormat:@"%@: %@",commentModel.user.nickname,commentModel.words];
        [view addSubview:userNameAndCommentLabel];
        
        UIControl * ctrl =[[UIControl alloc]initWithFrame:view.bounds];
        [ctrl addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ctrl];
        [_commentsScrollView addSubview:view];
        
    }
}
-(void)controlClick
{
    NSLog(@"????");
}
//动态效果
-(void)refreshCommentsScrollView
{
    
}
-(void)setJingXuanModel:(JingXuanModel *)jingXuanModel
{
    _jingXuanModel =jingXuanModel;
    
    //增添数据
    NSString * contentPURL =[NSString stringWithFormat:@"%@f1400/%@",_jingXuanModel.picdomain,_jingXuanModel.coverpic];
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:contentPURL]];
    
    _titleLabel.text =_jingXuanModel.title;
    _collectionCountLabel.text =_jingXuanModel.likeCnt;
    _pictureCountLabel.text =_jingXuanModel.cntP;
    //评论部分
    if (isLoadData==NO&&jingXuanModel!=nil) {
        [self initCommentsScrollView];
        isLoadData =YES;
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
