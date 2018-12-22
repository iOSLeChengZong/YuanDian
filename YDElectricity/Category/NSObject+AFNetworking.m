//
//  NSObject+AFNetworking.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//该类对AFNetworking进行封装

#import "NSObject+AFNetworking.h"

@implementation NSObject (AFNetworking)
+(id)GET:(NSString *)path parameters:(id)parmeters progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    return [manager GET:path parameters:parmeters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil,error);
        NSLog(@"error %@",error);
    }];
    
    
    
}
    
+(id)POST:(NSString *)path parameters:(id)paremeters progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager POST:path parameters:paremeters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completionHandler(nil,error);
    }];
    
}
@end
