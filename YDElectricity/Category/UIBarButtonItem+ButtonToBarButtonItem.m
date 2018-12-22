//
//  UIBarButtonItem+ButtonToBarButtonItem.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "UIBarButtonItem+ButtonToBarButtonItem.h"

@implementation UIBarButtonItem (ButtonToBarButtonItem)
+(instancetype)BarButtonItemWithTitle:(NSString *)title stytle:(UIBarButtonItemStyle)stytle target:(id)target action:(SEL)action{
    return [[self alloc] initWithTitle:title style:stytle target:target action:action];
}

+(instancetype)BarButtonItemWithBackgrounImageName:(NSString *)backgroundImageName highBackgroundImageName:(NSString *)hightBackgroundImageName target:(id)target aciton:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightBackgroundImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+(instancetype)BarButtonItemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"" size:15];//[UIFont systemFontOfSize:15];
    }
    
    //设置按钮的尺寸为背景图尺寸 + 文字大小n尺寸
    button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //设置title在button上的位置(top left buttom right)
    button.titleEdgeInsets = UIEdgeInsetsMake(30, -30, 0, 0);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
