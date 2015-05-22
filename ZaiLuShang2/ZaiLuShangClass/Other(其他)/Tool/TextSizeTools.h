//
//  TextSizeTools.h
//  ZaiLuShang
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextSizeTools : NSObject
+(CGSize)sizeWithString:(NSString *)str withMaxSize:(CGSize)maxSize withFont:(UIFont *)font;
@end
