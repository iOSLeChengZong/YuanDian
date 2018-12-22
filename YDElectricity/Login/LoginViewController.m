//
//  LoginViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//微信登陆
- (IBAction)OnWeChatBtnClick:(id)sender {
    //本地查询微信返回的userid 和token
    //如果没有,请求微信授权
    
    //test
    [self performSegueWithIdentifier:kPhoneNumSegue sender:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@""];
    
}




//游客登陆  游客登陆条件:首次登陆,退出登陆,注销账号
- (IBAction)OnVisitorBtnClick:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMainTab];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
