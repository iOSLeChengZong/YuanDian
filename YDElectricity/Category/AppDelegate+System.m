//
//  AppDelegate+System.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "AppDelegate+System.h"
#import <MLTransition.h>

@implementation AppDelegate (System)
    
    
- (void)setupGlobalClobalConfig{
    //电池条显示菊花,监测网络活动
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@",AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开始监控网络状态
    
    //自定左角返回按钮,导致右划返回失效
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
    //设置全局UINavigationBar 和 UITabbar
//    [self setupGlobalUI];
    
}
    
    
- (void)setupGlobalUI{
    //设置UINavigationBar
//    [UINavigationBar appearance].barStyle = UIBarStyleBlack;    //为了让电池条呈现白色
    [UINavigationBar appearance].translucent = NO;
//    [UINavigationBar appearance].barTintColor = kNaviBarBGColor;
    [[UINavigationBar appearance] setBarTintColor:kNaviBarBGColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    
    //设置UITabBar
    [UITabBar appearance].translucent = NO;//为了使用设置的颜色与正常的颜色没有色差
    [UITabBar appearance].barTintColor = kRGBA(237, 236, 235, 1.0);
    self.window.tintColor = kNaviBarBGColor;

    
    
}
- (BOOL)isOnLine{
    switch (self.netReachStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable:
        return NO;
        break;
        
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
        return YES;
        break;
        
    }
}
    
    - (AFNetworkReachabilityStatus)netReachStatus{
        return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    }
  
    
    
    
//以下是系统方法
    //app将要暂停
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
    
    //app进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
    
    //app将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
    
    //app重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
    
    //app将要终止
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
