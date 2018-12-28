//
//  YDNetManager.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "YDNetManager.h"

@implementation YDNetManager
+(id)search:(NSString *)words completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"" forKey:@""];
    //防止words为空
    [params setObject:words ?: @"" forKey:@"p[key]"];
    return [self POST:@"" parameters:params progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        !completionHandler ?: completionHandler(responseObj,error);
    }];

}

+(id)getTestDataWithPath:(NSString *)path page:(NSInteger)page goodsStatus:(NSInteger)status completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:status] forKey:@"goodsStatus"];
    return [self GET:path parameters:params progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"model:%@",responseObj);
        }else{
            NSLog(@"?????????");
        }
    }];
}


+(id)getHomeHeaderDataWithPath:(NSString *)path completionHandler:(void (^)(HomeHeaderModel * _Nonnull, NSError * _Nonnull))completionHandler{
    return [self POST:path parameters:nil progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([HomeHeaderModel parse:responseObj],error);
        }
    }];
}



+(id)getHomeGoodListDataWithPath:(NSString *)path pageNum:(NSInteger)page goodNum:(NSInteger)goodNum state:(NSInteger)state completionHandler:(void (^)(HomeGoodModel * _Nonnull, NSError * _Nonnull))completionHandler{
    
    NSMutableDictionary *parmas = [NSMutableDictionary new];
    [parmas setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [parmas setObject:[NSString stringWithFormat:@"%ld",goodNum] forKey:@"pageSize"];
    [parmas setObject:[NSString stringWithFormat:@"%ld",state] forKey:@"state"];
    
    return [self POST:path parameters:parmas progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([HomeGoodModel parse:responseObj],error);
//            HomeGoodModel *hm = [HomeGoodModel parse:responseObj];
//
//            NSLog(@"YYYYY:%lu,lllll:%@",hm.pageList.count,hm.pageList[0]);
        }
    }];
}


//分类
+(id)getCategortyLeftDataWithPath:(NSString *)path completionHandler:(void (^)(CategoryLeftMenuModel * _Nonnull, NSError * _Nonnull))completionHandler{
    return [self POST:path parameters:nil progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([CategoryLeftMenuModel parse:responseObj],error);
        }
    }];
}

+(id)getCategoryRightDataWithPath:(NSString *)path parameter:(NSString *)parameter completionHandler:(void (^)(CategoryRightMenuModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    [paramsDic setObject:parameter forKey:@"parentId"];
    
    return [self POST:path parameters:paramsDic progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"RightresponsObj:%@",responseObj);
            !completionHandler ?: completionHandler([CategoryRightMenuModel parse:responseObj],error);
        }
    }];
}



//test
+(id)getShopInfoWithPath:(NSString *)path param:(NSString *)params completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:params forKey:@"data"];
    
    return [self GETAllPath:path parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"model:%@",responseObj);
            if (responseObj != nil) {
                completionHandler(responseObj,error);
            }else{
                NSLog(@"数据为空!!!!!!!!!!!!!!");
            }
            
        }else{
            NSLog(@"?????????");
        }
    }];
 
}
@end
