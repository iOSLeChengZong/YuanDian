//
//  HomeHeaderCollectionViewCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCollectionViewCell : UICollectionViewCell<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) HomeViewModel *homeVM;
@property (strong,nonatomic) NSArray<NSString *> *imageURLs;


@end

NS_ASSUME_NONNULL_END
