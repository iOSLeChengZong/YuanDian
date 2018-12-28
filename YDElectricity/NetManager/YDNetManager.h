//
//  YDNetManager.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//此类与NSObject+AFNetworking交互,获得请求数据,JSON转模型,并给viewModel提供对外接口

#import <Foundation/Foundation.h>
#import "HomeHeaderModel.h"
#import "HomeGoodModel.h"
#import "CategoryLeftMenuModel.h"
#import "CategoryRightMenuModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface YDNetManager : NSObject

//第一次数据测试
+ (id)getTestDataWithPath:(NSString *)path page:(NSInteger)page  goodsStatus:(NSInteger)status completionHandler:(void(^)(id model ,NSError *error))completionHandler;

//搜索功能
+ (id)search:(NSString *)words completionHandler:(void(^)(id model,NSError *error))completionHandler;

//首页数据分为两次请求
//1.请求头部数据
+ (id)getHomeHeaderDataWithPath:(NSString *)path completionHandler:(void(^)(HomeHeaderModel *model,NSError *error))completionHandler;

//2.
/**
 请求首页商品数据

 @param path 请求路径
 @param page 请求页数
 @param goodNum 请求数量
 @param state 是热销,还是人气
 @param completionHandler 回调
 @return 模型数据
 */
+ (id)getHomeGoodListDataWithPath:(NSString *)path pageNum:(NSInteger)page goodNum:(NSInteger)goodNum state:(NSInteger)state completionHandler:(void(^)(HomeGoodModel *model,NSError *error))completionHandler;


//获取分类数据
+ (id)getCategortyLeftDataWithPath:(NSString *)path completionHandler:(void(^)(CategoryLeftMenuModel *model,NSError *error))completionHandler;
+ (id)getCategoryRightDataWithPath:(NSString *)path parameter:(NSString *)parameter completionHandler:(void(^)(CategoryRightMenuModel *model,NSError *error))completionHandler;


//test
+ (id)getShopInfoWithPath:(NSString *)path param:(NSString *)params completionHandler:(void(^)(id model,NSError *error))completionHandler;



@end

NS_ASSUME_NONNULL_END
