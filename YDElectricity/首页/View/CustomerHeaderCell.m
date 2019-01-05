//
//  CustomerHeader.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CustomerHeaderCell.h"

@implementation CustomerHeaderCell

-(void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup{
    _imageURLStringsGroup = imageURLStringsGroup;
    [self setUpScycelScrollViewImage];
}

-(void)setUpScycelScrollViewImage{
    _cycleScrollView.autoScroll = NO;
    _cycleScrollView.infiniteLoop = NO;
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    _cycleScrollView.imageURLStringsGroup = self.imageURLStringsGroup;
    
    UIView * View=[[UIImageView alloc]init];
    View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    View.frame=CGRectMake(_cycleScrollView.size.width-65, _cycleScrollView.size.height-38, 45, 17);
    [View viewcornerRadius:View.bounds.size.height * 0.5 borderWith:0.01 clearColor:NO];
    [_cycleScrollView addSubview:View];
    _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, View.size.width, View.size.height)];
    _indexPage.textAlignment = NSTextAlignmentCenter;
    _indexPage.font=[UIFont systemFontOfSize:10];
    _indexPage.textColor=[UIColor whiteColor];
    _indexPage.text = [NSString stringWithFormat:@"1/%lu",self.imageURLStringsGroup.count];
    [View addSubview:_indexPage];
    
    
    
}


#pragma mark -- 生命周期


- (void)awakeFromNib {
    [super awakeFromNib];
}


#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.indexPage.text = [NSString stringWithFormat:@"%ld/%lu",(index + 1),self.imageURLStringsGroup.count];
}
@end
