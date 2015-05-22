//
//  TextSizeTools.m
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TextSizeTools.h"

@implementation TextSizeTools
+(CGSize)sizeWithString:(NSString *)str withMaxSize:(CGSize)maxSize withFont:(UIFont *)font
{
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
