//
//  Factory.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//


#import "Factory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Factory
+ (BOOL)isPhoneNumber:(NSString *)phoneNum{
//    return phoneNum.length == 11 && phoneNum.doubleValue > 10000000000;
    
    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    return [pre evaluateWithObject:phoneNum];//此处返回的是BOOL类型,YES or NO;
    
}


+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (void)addBackItemToVC:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回_按下"] forState:UIControlStateHighlighted];
    
    [btn bk_addEventHandler:^(id sender) {
        [vc.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //弹簧控件, 修复边距
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
}

+ (void)playVideo:(NSURL *)videoURL{
//    YDPlayerViewController *vc = [YDPlayerViewController new];
//    AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:videoURL];
//    vc.player = [AVPlayer playerWithPlayerItem:playItem];
//    [vc.player play];
//    [kAppdelegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)(void))clickHandler{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 42, 50, 44);
    CGRect frame = btn.frame;
    
    btn.center = CGPointMake(kScreenW * 0.5, 42);
    frame.size = CGSizeMake(264 * kWidthScall, 31);
    
    NSLog(@"buttonCenter:%f",btn.center.x);
    
    btn.frame =  frame;
    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang0"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang1"] forState:UIControlStateHighlighted];
    
//    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
//    btn.autoresizesSubviews = YES;
//
//    CGRect leftViewbounds = vc.navigationItem.leftBarButtonItem.customView.bounds;
//    CGRect rightViewbounds = vc.navigationItem.rightBarButtonItem.customView.bounds;
//    
//
//    CGRect frame1;
//    CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
//    maxWidth += 15;//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
//    frame1 = btn.frame;
//
//    frame1.size.width = kScreenW - maxWidth * 2;
//    btn.frame = frame1;
    
    
    vc.navigationItem.titleView = btn;

    NSLog(@"navCenter:%f",vc.navigationItem.titleView.center.x);
    [btn bk_addEventHandler:^(id sender) {
        clickHandler();
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    //弹簧控件, 修复边距
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -15;
//    vc.navigationItem.rightBarButtonItems = @[spaceItem/*,backItem*/];
    
}
@end
