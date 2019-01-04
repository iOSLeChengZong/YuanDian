//
//  PersonalEditorDataViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/2.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "PersonalEditorDataViewController.h"

@interface PersonalEditorDataViewController ()

@end

@implementation PersonalEditorDataViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)editorVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
