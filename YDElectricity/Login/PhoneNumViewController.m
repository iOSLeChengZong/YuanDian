//
//  PhoneNumViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PhoneNumViewController.h"

@interface PhoneNumViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTexfield;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTexfield;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;


@property (assign,nonatomic) NSInteger countDownInterverl;
@property (strong,nonatomic) NSTimer *timer;

@end

@implementation PhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setUpCountDownInterverl:(NSInteger) interverl{
    
    _countDownInterverl = interverl;
    if (_countDownInterverl!=0) {
        self.verifyBtn.enabled = NO;
        WK(weakSelf)
        self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            weakSelf.countDownInterverl--;
            [weakSelf.verifyBtn setTitle:[NSString stringWithFormat:@"%lds",weakSelf.countDownInterverl] forState:UIControlStateNormal];
            if (weakSelf.countDownInterverl == 0) {
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
                weakSelf.verifyBtn.enabled = YES;
                [weakSelf.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            }
        } repeats:YES];
    }
}

- (IBAction)OnVerifyBtnClick:(id)sender {
    //向服务器发送验证请求
    
    //倒计时两分钟
    [self setUpCountDownInterverl:10];
    
}


- (IBAction)OnNextStepBtnClick:(id)sender {
    //正在发送验证请求,菊花转
    
    //验证结果HBHUD
    //进入下一步
    
    
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
