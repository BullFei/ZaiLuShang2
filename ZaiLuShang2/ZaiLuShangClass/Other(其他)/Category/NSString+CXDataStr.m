//
//  NSString+CXDataStr.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSString+CXDataStr.h"

@implementation NSString (CXDataStr)

- (NSMutableAttributedString *)toDataStr
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *selfDate = [fm dateFromString:self];
    
    // 日历对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitSecond | NSCalendarUnitMinute;
    // 当前时间
    NSDate *now = [NSDate date];
    NSDateComponents *nowCom = [cal components:unit fromDate:now];
    // 创建时间
    NSDateComponents *selfCom = [cal components:unit fromDate:selfDate];
    // 比较值
    NSDateComponents *com = [cal components:unit fromDate:selfDate toDate:now options:0];
    
    NSLog(@"%@", nowCom);
    NSLog(@"%@", selfCom);
    
    NSLog(@"%@", com);
    
    NSDateFormatter *chinaFm = [[NSDateFormatter alloc] init];
    chinaFm.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSString *str = [chinaFm stringFromDate:selfDate];
    
    NSMutableAttributedString *mabs = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableString *strM = [NSMutableString string];
    
    if (com.year == 0) {
        [mabs deleteCharactersInRange:NSMakeRange(0, 5)];
        if (com.month == 0) {
            [mabs addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
            if (com.day == 0) {
                [mabs addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(3, 3)];
                if (com.hour == 0) {
                    [mabs addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 3)];
                    if (com.second == 0) {
                        [mabs addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(9, 3)];
                    }
                }
            }
        }
    } else {
        
    }
    
    
    
    return mabs;
}

@end
