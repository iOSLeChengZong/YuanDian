//
//  PersonalLogonHeader.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PersonalLogonHeader.h"

@implementation PersonalLogonHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)OnMessageBtnClick:(id)sender {
    NSLog(@"OnMessageBtnClick");
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickMessage);
}

- (IBAction)OnEditorBtnClick:(id)sender {
    NSLog(@"OnEditorBtnClick");
    
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickEditor);
}


-(void)addClickHandler:(void (^)(PersonalLogonHeaderClick))handler{
    _personalClickHander = handler;
}


@end
