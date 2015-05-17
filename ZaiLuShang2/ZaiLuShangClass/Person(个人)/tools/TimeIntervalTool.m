//
//  TimeIntervalTool.m
//  ZaiLuShang2
//
//  Created by ChangLuyang on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TimeIntervalTool.h"

#define LYZLS_SECONDS_OF_A_DAY (24*60*60)
#define LYZLS_SECONDS_OF_AN_HOUR (60*60)

@implementation TimeIntervalTool

+ (NSString *)timeIntervalFromTimeString:(NSString *)timeString {
    // 时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 以前的某个时间
    NSDate *sometime = [formatter dateFromString:timeString];
    
    NSTimeInterval nowInterval = [now timeIntervalSince1970];
    NSTimeInterval sometimeInterval = [sometime timeIntervalSince1970];
    NSTimeInterval realInterval = nowInterval - sometimeInterval;
    
    if (realInterval < 3600) {
        return @"刚刚";
    } else if (realInterval >= 3600 && realInterval < 24 * 3600) {
        NSInteger n = (int)realInterval / 3600;
        return [NSString stringWithFormat:@"%ld小时前", (long)n];
    } else if (realInterval >= 24 * 3600 && realInterval < 10 * 24 * 3600) {
        NSInteger n = (int)realInterval / (24 * 3600);
        return [NSString stringWithFormat:@"%ld天前", n+1];
    } else {
        NSDateFormatter *shortFormatter = [[NSDateFormatter alloc] init];
        [shortFormatter setDateFormat:@"MM.dd"];
        return [shortFormatter stringFromDate:sometime];
    }
}

@end
