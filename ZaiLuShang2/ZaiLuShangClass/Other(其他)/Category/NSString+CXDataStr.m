//
//  NSString+CXDataStr.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSString+CXDataStr.h"

@implementation NSString (CXDataStr)

- (NSString *)toDataStr
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *selfDate = [fm dateFromString:self];
    
    // 日历对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitSecond | NSCalendarUnitMinute;
    // 当前时间
    NSDate *now = [NSDate date];
    // 创建时间
    NSDateComponents *selfCom = [cal components:unit fromDate:selfDate];
    // 比较值
    NSDateComponents *com = [cal components:unit fromDate:selfDate toDate:now options:0];
    
    if (com.year != 0) {
        fm.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fm stringFromDate:selfDate];
    } else if (com.month != 0) {
        fm.dateFormat = @"MM-dd HH:mm";
        return [fm stringFromDate:selfDate];
    } else if (com.day != 0) {
        if (com.day == 1) {
            fm.dateFormat = @"昨天 HH:mm";
            return [fm stringFromDate:selfDate];
        } else if (com.day == 2) {
            fm.dateFormat = @"前天 HH:mm";
            return [fm stringFromDate:selfDate];
        }
        fm.dateFormat = @"MM-dd HH:mm";
        return [fm stringFromDate:selfDate];
    } else if (com.hour != 0) {
        fm.dateFormat = @"HH小时前";
        return [fm stringFromDate:selfDate];
    } else if (com.minute != 0) {
        fm.dateFormat = @"mm分钟前";
        return [fm stringFromDate:selfDate];
    } else {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
}


@end
