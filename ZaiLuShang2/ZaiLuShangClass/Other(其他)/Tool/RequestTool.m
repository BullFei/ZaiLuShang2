//
//  RequestTool.m
//  ChanYouJi
//
//  Created by gaocaixin on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RequestTool.h"
#import "AFNTool.h"
#import "MyMD5.h"
#import "MBProgressHUD+MJ.h"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define CACHES_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


#define REQUEST_CACHES @"REQUEST_CACHES"

@implementation RequestTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    NSFileManager *fileM = [NSFileManager defaultManager];
    // 缓存路径
    NSString *requestPath = [CACHES_PATH stringByAppendingPathComponent:REQUEST_CACHES];
    // 文件路径
    NSString *filePath = [requestPath stringByAppendingPathComponent:[MyMD5 md5:URLString]];
    
    [AFNTool GET:URLString parameters:parameters success:^(id responseObject) {
        // 缓存处理
        NSData *data = (NSData *)responseObject;
                // 创建文件
        if (![fileM fileExistsAtPath:requestPath isDirectory:nil]) {
            [fileM createDirectoryAtPath:requestPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [data writeToFile:filePath atomically:YES];
        
        if (success) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(responseObject);
        }
    } failure:^(NSError *error) {
        
        // 存在缓存文件夹
        if ([fileM fileExistsAtPath:filePath]) {
            // 取数据
            NSData *responseObject = [NSData dataWithContentsOfFile:filePath];
            // 返回数据
            if (success) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(responseObject);
            }
        }
        
        if (failure) {
            failure(error);
        }
    }];
   
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [AFNTool POST:URLString parameters:parameters success:^(id responseObject) {
        // 缓存处理
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (id)dataToDict:(NSData *)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


@end
