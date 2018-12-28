//
//  AppDelegate.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import <MJExtension.h>
#import "MJStudent.h"
#import "MJBag.h"

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "AppDelegate+YDShareSDK.h"

#import "Person.h"
#import "CityDataViewModel.h"
#import "YDNetManager.h"


@interface AppDelegate ()
@property(nonatomic,strong)CityDataViewModel *cityDataVM;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //程序开始启动
    //设置app全局默认配置
    [self setupGlobalClobalConfig];

//    [YDNetManager getHomeHeaderDataWithPath:kHomeHederDataURL completionHandler:^(id  _Nonnull model, NSError * _Nonnull error) {
//        NSLog(@"HeaderDataresponObj:%@",model);
//    }];
//
//    [YDNetManager getHomeGoodListDataWithPath:kHomeGoodListURL pageNum:1 goodNum:20 state:1 completionHandler:^(id  _Nonnull model, NSError * _Nonnull error) {
//        NSLog(@"GoodListresponObj:%@",model);
//    }];
    

    
//    [YDNetManager getCategortyLeftDataWithPath:kCategoryModelURL completionHandler:^(CategoryLeftMenuModel * _Nonnull model, NSError * _Nonnull error) {
//        NSLog(@"=====%@",model.categoryModels[0].ID);
//        [YDNetManager getCategoryRightDataWithPath:kCategoryModelURL parameter:model.categoryModels[0].ID completionHandler:^(id  _Nonnull mode, NSError * _Nonnull error) {
//
//        }];
//
//    }];
    
    
    //请求分类左边数据
//    [YDNetManager getCategortyLeftDataWithPath:kCategoryModelURL completionHandler:^(CategoryLeftMenuModel * _Nonnull model, NSError * _Nonnull error) {
//        NSLog(@"====");
//    }];
    
    
    
    

    
    //@"https://acs.m.taobao.com/h5/mtop.taobao.detail.getdetail/6.0/?data={%22itemNumId%22%3A%22549893090068%22}"
    
    
    [YDNetManager getShopInfoWithPath:@"/h5/mtop.taobao.detail.getdetail/6.0/" param:@"{%22itemNumId%22%3A%22549893090068%22}" completionHandler:^(id  _Nonnull model, NSError * _Nonnull error) {
        NSLog(@"====");
    }];
    
    

    

    
    
    
    
    
    //请求分类右边数据
//    [YDNetManager getCategoryRightDataWithPath:kCategoryModelURL parameter:@"37" completionHandler:^(CategoryRightMenuModel * _Nonnull model, NSError * _Nonnull error) {
//        
//    }];
    
    //调试首页头部数据
//    [YDNetManager getHomeHeaderDataWithPath:kHomeHederDataURL completionHandler:^(HomeHeaderModel * _Nonnull model, NSError * _Nonnull error) {
//        NSLog(@"-----");
//    }];
    
    
    //调试首页商品数据
//    [YDNetManager getHomeGoodListDataWithPath:kHomeGoodListDataURL pageNum:1 goodNum:20 state:1 completionHandler:^(HomeGoodModel * _Nonnull model, NSError * _Nonnull error) {
//         NSLog(@"-----");
//    }];
    
    
    //设置ShareSDK的Appkey并初始化对应的第三方社交平台
//    [self didFinishLaunchingWithOptionsForShareSDK];
//
//
//
//    //Runtiem
//    Person *p = [Person new];
//    [p getAllIvarList];
//    [p getAllProperty];
//
//
//    //测试Plist数据
//    [self.cityDataVM getCityDataCompletionHandler:^(NSError * _Nonnull error) {
//        NSLog(@"===");
//    }];
//
    return YES;
}


-(CityDataViewModel *)cityDataVM{
    if (!_cityDataVM) {
        _cityDataVM = [CityDataViewModel new];
    }
    return _cityDataVM;
}

@end
