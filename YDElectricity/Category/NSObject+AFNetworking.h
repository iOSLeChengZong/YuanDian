//
//  NSObject+AFNetworking.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AFNetworking)

//GET请求
+ (id)GET:(NSString *)path parameters:(id)parmeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;

//GET请求 allPath
+ (id)GETAllPath:(NSString *)path parameters:(id)parmeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;

//POST请求
+ (id)POST:(NSString *)path parameters:(id)paremeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;

    
@end

NS_ASSUME_NONNULL_END
