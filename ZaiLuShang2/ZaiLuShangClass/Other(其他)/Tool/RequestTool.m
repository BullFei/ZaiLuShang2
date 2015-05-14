//
//  RequestTool.m
//  ChanYouJi
//
//  Created by gaocaixin on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RequestTool.h"
#import "AFNTool.h"

@implementation RequestTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [AFNTool GET:URLString parameters:parameters success:^(id responseObject) {
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

@end
