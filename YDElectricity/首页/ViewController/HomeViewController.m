//
//  HomeViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+ButtonToBarButtonItem.h"
#import "SearchBarView.h"
#import "HomeHeaderCollectionViewCell.h"
#import "HomeSectionHeaderView.h"
#import "HomeProductCell.h"
#import "CategoryViewController.h"
#import "HomeViewModel.h"
#import "InHomeHeaderCell.h"
#import "Factory.h"


#define kHomeHeaderCollectionViewCell @"HomeHeaderCollectionViewCell"
#define kHomeSectionHeaderView @"HomeSectionHeaderView"
#define kHomeProductCell @"HomeProductCell"
#define kInHomeHeaderCell @"InHomeHeaderCell"



@interface HomeViewController ()<SearchBarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,strong) HomeViewModel *homeVM;
@property (nonatomic,assign) HotOrRecomend hotOrRecomend;
@property (nonatomic,assign) RequestMode requestMode;


@end

@implementation HomeViewController

#pragma mark -- 懒加载
-(HomeViewModel *)homeVM
{
    if (!_homeVM) {
        _homeVM = [HomeViewModel new];
    }
    return _homeVM;
}



#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册collectionViewCell
    [self collectionRegisterCell];
    
    //请求数据
    [self.view showBusyHUD];
//    [self requestData];

    //添加头部脚部刷新
//    [self addHeaderAndFooterRefresh];
    //设置顶部导航栏
    [self setUpNavigagionItem];

}


#pragma mark -- SearchBarViewDelegate
-(void)searchBarSearchBtnClicked:(id)searchBarView{
    NSLog(@"SearchBarBtn被点击:%@",[searchBarView class]);
}

#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return [self.homeVM goodCollectionVItemNum];
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        HomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeHeaderCollectionViewCell forIndexPath:indexPath];
        [cell.collectionV registerNib:[UINib nibWithNibName:kInHomeHeaderCell bundle:nil] forCellWithReuseIdentifier:kInHomeHeaderCell];
        cell.homeVM = self.homeVM;
        
        return cell;
    }else{
        HomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeProductCell forIndexPath:indexPath];
        //商品主图
        [cell.productImageView sd_setImageWithURL:[self.homeVM goodCollectionVItemImageURLAtIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@""]];
        //商品标题
        cell.productTitleLabel0.text = [self.homeVM goodCollectionVItemMainTitleAtIndexPath:indexPath];
        //商品优惠
        cell.productTitleLabel1.text = [self.homeVM goodCollectionVItemSecondTitleAtIndexPath:indexPath];
        //商品原价
        cell.productFromMoneyLabel.text = [self.homeVM goodCollectionVItemSoursePriceAtIndexPath:indexPath];
        //优惠券
        cell.productFromeSaleMoneyLabel.text = [self.homeVM goodCollectionVitemTicketPriceAtIndexPath:indexPath];
        //折后价
        cell.productAfterSaleMoneyLabel.text = [self.homeVM goodCollectionVItemAfterSalePriceAtIndexPath:indexPath];
        //收益
        cell.profitMoney.text = [self.homeVM goodCollectionVItemProfitAtIndexPath:indexPath];
        return cell;
    }
    
}

//分区数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}


//分区头部和脚部视图
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kHomeSectionHeaderView;
    }else{
        reuseIdentifier = kHomeSectionHeaderView;
    }
    
    HomeSectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [view addClickHandler:^(RequestMode requestMode,HotOrRecomend hotOrRecomend) {
        if (self.requestMode == requestMode && self.hotOrRecomend == hotOrRecomend) {
            return ;
        }
        self.requestMode = requestMode;
        self.hotOrRecomend = hotOrRecomend;
        //忙提示
        [self.view showBusyHUD];
        [self.homeVM getHomeGoodModelDataRequestMode:RequestModeRefresh pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.view hideBusyHUD];
                return ;
            }
            [self.view showWarning:@"网络错误"];
        }];
        
    }];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
    
        
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        view.frame = CGRectZero;
        
    }
    
    return view;
}

#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath:%lu",indexPath.row);

}

#pragma mark -- collectionViewDelegateFlowLayout
//item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenW, kHight * 436);
    }
    return CGSizeMake(kScreenW, 150);
}

//分区之间间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//分区头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenW, 50);;
}

//分区脚部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark -- UIScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if (scrollView==self.collectionView) {
//        
//        NSLog(@"%f",scrollView.contentOffset.y);
//        CGFloat offsetY = scrollView.contentOffset.y;
//        if (scrollView.contentOffset.y>=-20 && scrollView.contentOffset.y<50) {
//            self.navigationController.navigationBarHidden = NO;
//            
//            self.topView.backgroundColor=[UIColor colorWithRed:226/255.0f green:67/255.0f  blue:70/255.0f  alpha:offsetY*2/100];
//            
//            //NSLog(@"变色");
//        }else if (scrollView.contentOffset.y<-20){
//            
//            self.navigationController.navigationBarHidden = YES;
//            self.topView.backgroundColor=[UIColor colorWithRed:226/255.0f green:67/255.0f  blue:70/255.0f  alpha:0.0];
//        }else{
//            
//            self.navigationController.navigationBarHidden = NO;
//            self.topView.backgroundColor=[UIColor colorWithRed:226/255.0f green:67/255.0f  blue:70/255.0f  alpha:0.9];
//        }
//        
//    }
    
}

#pragma mark -- 方法
-(void)setUpNavigagionItem{
    //设置背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"分类" stytle:UIBarButtonItemStylePlain target:self action:@selector(categoryBtnClick)];
    //设置右侧按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgrounImageName:@"y_h_shoppingCart1" highBackgroundImageName:@"y_h_shoppingCart1" target:self aciton:@selector(shopCarBtnClick)];
    //将将搜索条放在titleView上
//    SearchBarView *searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, 7, 240, 30)];
//    searchView.delegate = self;
    [Factory addSearchItemToVC:self clickHandler:^{
        NSLog(@"搜索被点击了");
    }];
//    self.navigationItem.titleView = searchView;

}

-(void)categoryBtnClick{
    NSLog(@"首页分类按钮被点击了");
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"Back";
    self.navigationItem.backBarButtonItem = backItem;
//    [self showViewController:cvc sender:nil];
    [self.navigationController pushViewController:cvc animated:YES];
    
}

-(void)shopCarBtnClick{
    NSLog(@"购物车按钮被点击了");
}

-(void)collectionRegisterCell{
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeHeaderCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kHomeHeaderCollectionViewCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeSectionHeaderView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderView];
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeProductCell bundle:nil] forCellWithReuseIdentifier:kHomeProductCell];
}

-(void)addHeaderAndFooterRefresh{
    //添加头部刷新
    [self.collectionView addHeaderRefreshingBlock:^{
        [self requestData];
        
    }];
    
    //添加脚部刷新
    [self.collectionView addFooterBackRefresh:^{
        [self.homeVM getHomeHeaderModelDataCompletionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                [self.homeVM getHomeGoodModelDataRequestMode:RequestModeMore pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
                    if (!error) {
                        [self.collectionView reloadData];
                        [self.collectionView endFooterRefresh];
                    }
                }];
            }
        }];
    }];
}

-(void)requestData{
    [self.collectionView addHeaderRefreshingBlock:^{
        //请求头部数据
        [self.homeVM getHomeHeaderModelDataCompletionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                [self.homeVM getHomeGoodModelDataRequestMode:RequestModeRefresh pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
                    if (!error) {
                        [self.collectionView reloadData];
                        [self.view hideBusyHUD];
                        return ;
                    }
                    [self.view showWarning:@"网络错误"];
                }];
                return ;
            }
            [self.view showWarning:@"网络错误"];
        }];
    }];
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
