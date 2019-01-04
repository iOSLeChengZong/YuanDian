//
//  HomeHeaderCollectionViewCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeHeaderCollectionViewCell.h"
#import "HomeViewModel.h"
#import "InHomeHeaderCell.h"

#define kMinimumLineSpacing  20

#define kMinimumInteritemSpacing 20
//每行显示的数量
#define kCellNumberPerLine  4
//cell的高度
#define kCellHigh 30

#define kInHomeHeaderCell @"InHomeHeaderCell"

@interface HomeHeaderCollectionViewCell()
@property(strong,nonatomic)NSArray *titleArray;
@property(strong,nonatomic)NSArray *imageNames;


@end

@implementation HomeHeaderCollectionViewCell

-(void)setHomeVM:(HomeViewModel *)homeVM{
    _homeVM = homeVM;
    //设置轮播图
    self.imageURLs = [self.homeVM advertiseURLS];
    
    //设置秒杀商品
    //设置秒杀商品圆角
    [self.imageViewParentV viewcornerRadius:5 borderWith:0.01 clearColor:YES];
    
    [self.imageView sd_setImageWithURL:[self.homeVM secondSkillGoodURL] placeholderImage:[UIImage imageNamed:@"h1"]];
    
    [self.collectionV reloadData];
}

-(void)setImageURLs:(NSArray<NSString *> *)imageURLs{
    _imageURLs = imageURLs;
    [self setUpCycleScrollview];
}


- (void)awakeFromNib {
    [super awakeFromNib];
//    [self addChildViewToScrollV];
    self.imageNames = @[@"y_h_9.9元区icon",@"y_h_限时特卖",@"y_h_精选特品",@"y_h_加盟精品",@"y_h_金币商城"];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.cycleScrollView.delegate = self;
    
    
    /*
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            @"h7" // 本地图片请填写全名
                            ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    _imagesURLStrings = imagesURLStrings;
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"disableScrollGesture可以设置禁止拖动",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [demoContainerView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [demoContainerView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
 
//     block监听点击方式
//
//     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
//     NSLog(@">>>>>  %ld", (long)index);
//     };
    
    
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图3 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    
    [demoContainerView addSubview:cycleScrollView3];
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建只上下滚动展示文字的轮播器
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 750, w, 40) delegate:self placeholderImage:nil];
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    [titlesArray addObjectsFromArray:titles];
    cycleScrollView4.titlesGroup = [titlesArray copy];
    [cycleScrollView4 disableScrollGesture];
    
    [demoContainerView addSubview:cycleScrollView4];
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图5 自定义cell的轮播图 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法
    
    _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 820, w, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _customCellScrollViewDemo.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    _customCellScrollViewDemo.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    _customCellScrollViewDemo.imageURLStringsGroup = imagesURLStrings;
    
    [demoContainerView addSubview:_customCellScrollViewDemo];
    */
  
}

//// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法
//-(void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
//
//}
//
//-(Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
//    return nil;
//}

#pragma mark -- SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeVM.culomnitemNum;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InHomeHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInHomeHeaderCell forIndexPath:indexPath];
    cell.culomnTitle.text = [self.homeVM culomnCellTitleForItem:indexPath];
    
    //设置culomnImage圆角状态
    [cell viewcornerRadius:10 borderWith:0.01 clearColor:YES];
    cell.culomnImage.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidthScall*42.0, 61);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return ((self.bounds.size.width - (kWidthScall * 42.0 * self.homeVM.culomnitemNum))/self.homeVM.culomnitemNum);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat f = ((self.bounds.size.width - (kWidthScall * 42.0 * self.homeVM.culomnitemNum))/self.homeVM.culomnitemNum) / 2;
    return UIEdgeInsetsMake(14/*self.bounds.size.height/2*/, f/*((self.bounds.size.width - (kWidthScall * 42.0 * 5))/5)/2*/, 0/*self.bounds.size.height/2*/, f/*((self.bounds.size.width - (kWidthScall * 42.0 * 5))/5)/2*/);
}


#pragma mark -- 方法

//设置循环轮播图
-(void)setUpCycleScrollview{
    //设置代理

    //设置滚动方向
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ////     自定义分页控件小圆标颜色
    //    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    
    //自定义分布控件图片
//    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    
    
    //设置要展示图片的网络地址
    self.cycleScrollView.imageURLStringsGroup = self.imageURLs;

}


//向轮播图中添加子视图
-(void)addChildViewToScrollV{
    
    CGFloat letEdge = ((kScreenW - (kWidthScall * 65.0 * 5))/5) / 2;
    NSLog(@"seeDDDD:%f",letEdge);
    
    for (int i = 0; i < self.titleArray.count; ++i) {
        // W / H = 75 / 85    @2x
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"sns_icon_24.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"test1"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sns_icon_23"] forState:UIControlStateHighlighted];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:10];//[UIFont fontWithName:@"" size:15];//[UIFont systemFontOfSize:15];
        button.frame = CGRectMake(letEdge  + (kWidthScall * 65 + 2*letEdge) * i, 5, kWidthScall*65, 50);
        
        
        //设置按钮的尺寸为背景图尺寸 + 文字大小n尺寸
//        button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
//        button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        //设置title在button上的位置(top left buttom right)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -kWidthScall*65, 0, 0);
        
        //监听按钮点击
        
        
        
//        [self.scrollV addSubview:button];
//
//        self.scrollV.contentSize = CGSizeMake(CGRectGetMaxX([[self.scrollV subviews] lastObject].frame), self.scrollV.bounds.size.height);
    }
}

-(void)setUpSecondSkillImage
{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.homeVM.headerModel.rows.goodsSpikeList[0].pageImgUrl]] placeholderImage:[UIImage imageNamed:@""]];
}

-(void)addChildView{
    [self setUpCycleScrollview];
    [self addChildViewToScrollV];
    
}


@end
