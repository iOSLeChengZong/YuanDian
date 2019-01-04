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
    
}


#pragma mark -- 生命周期


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.indexPage.text = [NSString stringWithFormat:@"%ld/%lu",(index + 1),self.imageURLStringsGroup.count];
}
@end
