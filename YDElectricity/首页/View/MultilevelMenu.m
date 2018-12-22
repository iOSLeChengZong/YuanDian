//
//  MultilevelMenu.m
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "MultilevelMenu.h"
#import "MultilevelTableViewCell.h"
#import "MultilevelCollectionViewCell.h"
#import "CategoryMeunModel.h"
#import "UIImageView+WebCache.h"
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface MultilevelMenu()

@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@property(nonatomic,strong) NSMutableArray *offsetScorllers;

@end
@implementation MultilevelMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame WithModel:(CategoryViewModel *)categoryVM withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    
    if (self  == [super initWithFrame:frame]) {
        
        if (categoryVM.categoryModels.count == 0) {
            return nil;
        }
        
        _block=selectIndex;
        
        self.needToScorllerIndex=0; //默认是 选中第一行
        self.oldCellIndex = 0;//上一个被点击的cell默认为0;
        
        //tableView分离线颜色
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        
        //左边默认背景颜色
        self.leftBgColor = kNaviBarBGColor;
        //左边选中背景颜色
        self.leftSelectBgColor = [UIColor whiteColor];
        
        //左边未选中背景颜色
        self.leftUnSelectBgColor=kNaviBarBGColor;
        
        //左边点中字体颜色
        self.leftSelectColor=kRGBA(45, 188, 157, 1.0);
        //左边字体未选中颜色
        self.leftUnSelectColor = kRGBA(45, 188, 157, 1.0);
        
        self.isRecordLastScroll=NO;//是否记住当前位置
        
        _selectIndex=0;
        
        _categoryVM = categoryVM;
        
        _offsetScorllers = [NSMutableArray arrayWithCapacity:_categoryVM.categoryModels.count];
        
        //初始化数组
        for (int i = 0; i < _categoryVM.categoryModels.count; ++i) {
            self.offsetScorllers[i] = [NSNumber numberWithFloat:0];
        }
        
        
        /**
         左边的视图
        */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
//        self.leftTablew.separatorColor=self.leftSeparatorColor;
        self.leftTablew.separatorStyle = UITableViewCellSeparatorStyleNone;//设置没有分界线
        
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing=0.f;//左右间隔
        flowLayout.minimumLineSpacing=0.f;
        float leftMargin =0;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,0,kScreenWidth-kLeftWidth-leftMargin*2,frame.size.height) collectionViewLayout:flowLayout];
        
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        
        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
        
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        
        UINib *header=[UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
        [self.rightCollection registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        
        [self addSubview:self.rightCollection];
        
      
        self.isReturnLastOffset=YES;
        
        self.rightCollection.backgroundColor=self.leftSelectBgColor;

        self.backgroundColor=self.leftSelectBgColor;
        

        
    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    _needToScorllerIndex=needToScorllerIndex;
    [self adjustLeftTabaleViewOffset:_needToScorllerIndex];
}

-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
   
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    self.rightCollection.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}
#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark--dcollectionView里有多少个组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.categoryVM.categoryModels.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor=tableView.separatorColor;
        [cell addSubview:label];
        label.tag=100;
    }
    
    cell.backgroundColor = kNaviBarBGColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.titile.text=[self.categoryVM tableViewFroTitleForRowForTableViewAtIndexPath:indexPath];//title.menuName;
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    
    if (indexPath.row==self.selectIndex) {
        cell.titile.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
        line.backgroundColor=cell.backgroundColor;
    }
    else
    {
        cell.titile.textColor=self.leftUnSelectColor;
        cell.backgroundColor=self.leftUnSelectBgColor;
        line.backgroundColor=tableView.separatorColor;

    }
    

    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.titile.textColor= self.leftSelectColor;
    cell.backgroundColor= self.leftSelectBgColor;
    _selectIndex=indexPath.row;

    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor= cell.backgroundColor;
    
    //处理tableView滚动
//    [self adjustLeftTabaleViewOffset:_selectIndex];
    self.needToScorllerIndex = indexPath.row;
    
    self.isReturnLastOffset=NO;
    [self.rightCollection reloadData];
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, [self.offsetScorllers[self.selectIndex] floatValue], self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    else{
        
         [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    

}


#pragma mark---imageCollectionView--------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    if (self.categoryVM.categoryModels.count==0) {
        return 0;
    }
    
    return [self.categoryVM collectionViewForSectionNumber:self.selectIndex];//title.nextArray.count;
    
    
}
#pragma mark---每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    /*
    CategoryMeunModel * title=self.allData[self.selectIndex];
    
    if (title.nextArray.count>0) {
        
        CategoryMeunModel *sub=title.nextArray[section];
        
        if (sub.nextArray.count==0){//没有下一级
            
            return 1;
            
        }else{
            
            return sub.nextArray.count;
        }
        
    }else{
        
        return title.nextArray.count;
    }
    */
    NSInteger sectionNum = [self.categoryVM collectionViewForSectionNumber:self.selectIndex];
    NSInteger itemNum = [self.categoryVM collectionViewForRowNumberForSection:section tableViewIndex:self.selectIndex];
    if (sectionNum > 0) {
        if (itemNum == 0) {
            return 1;
        }else{
            return itemNum;
        }
    }else{
        return sectionNum;//0
    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    CategoryMeunModel * title=self.allData[self.selectIndex];
//    CategoryMeunModel * meun=title.nextArray[indexPath.section];
//
//    if (meun.nextArray.count>0) {
//        meun=title.nextArray[indexPath.section];
//        NSArray * list=meun.nextArray;
//        meun=list[indexPath.row];
//    }
//
//    void (^select)(NSInteger left,NSInteger right,id info) = self.block;
//    select(self.selectIndex,indexPath.row,meun);
    
}

#pragma mark---定义并返回每个cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    cell.titile.text = [self.categoryVM collectionViewForTitleForRowAtIndexPath:indexPath section:indexPath.section tableViewIndex:self.selectIndex];
    cell.imageView.backgroundColor=[UIColor whiteColor];
    NSString *imageName = [self.categoryVM collectionViewForImageNameForRowAtIndexPath:indexPath section:indexPath.section tableViewIndex:self.selectIndex];
    if (imageName) {
        cell.imageView.image= [UIImage imageNamed:imageName];
    }
    
   
    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[self.categoryVM collectionViewForImageNameForRowAtIndexPath:indexPath section:indexPath.section tableViewIndex:self.selectIndex]]
//                      placeholderImage:[UIImage imageNamed:[self.categoryVM collectionViewForImageNameForRowAtIndexPath:indexPath section:indexPath.section tableViewIndex:self.selectIndex]]];
    
    return cell;
}

#pragma mark---定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"footer";
    }else{
        reuseIdentifier = kMultilevelCollectionHeader;
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    UILabel *label = (UILabel *)[view viewWithTag:1];
//    label.font=[UIFont systemFontOfSize:14];
//    label.textColor=UIColorFromRGB(0x686868);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        if (self.categoryVM.categoryModels[self.selectIndex].topMenu.count > 0) {
            label.text = [self.categoryVM collectionViewForTitleForSection:indexPath.section tableViewIndex:self.selectIndex];
        }else{
            label.text=@"暂无";
        }
        
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是footer:%ld",(long)indexPath.section];
    }
    
    return view;
}

#pragma mark---UICollectionViewDelegateFlowLayout 是UICollectionViewDelegate的子协议
#pragma mark---每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    return CGSizeMake(80, 90);
}
#pragma mark---设置每组的cell的边界, 具体看下图
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark---cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}
#pragma mark---
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kScreenWidth,44};
    return size;
}


#pragma mark---记录滑动的坐标

//开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {

        self.isReturnLastOffset=YES;
    }
}

//结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        self.offsetScorllers[self.selectIndex] = [NSNumber numberWithFloat:scrollView.contentOffset.y];
        self.isReturnLastOffset=NO;
        
    }

 }

//减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        
        self.offsetScorllers[self.selectIndex] = [NSNumber numberWithFloat:scrollView.contentOffset.y];
        self.isReturnLastOffset=NO;
        
    }

}

//滚动完成
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {

        self.offsetScorllers[self.selectIndex] = [NSNumber numberWithFloat:scrollView.contentOffset.y];
        self.isRecordLastScroll = YES;
    }
}



#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}



#pragma mark -- 方法
-(void)adjustLeftTabaleViewOffset:(NSInteger)currentCellIndex{
    if (currentCellIndex == _oldCellIndex) {
        return;
    }
    MultilevelTableViewCell * oldCell=(MultilevelTableViewCell*)[self.leftTablew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_oldCellIndex inSection:0]];
    oldCell.titile.textColor = self.leftUnSelectColor;
    oldCell.backgroundColor = self.leftUnSelectBgColor;
    
    
    UILabel * line=(UILabel*)[oldCell viewWithTag:100];
    line.backgroundColor=oldCell.backgroundColor;

    
    MultilevelTableViewCell * currentCell=(MultilevelTableViewCell*)[self.leftTablew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentCellIndex inSection:0]];
    _oldCellIndex = currentCellIndex;
    
    //判断是需要滚动
    if (_leftTablew.contentSize.height > _leftTablew.frame.size.height){
        
        //偏移量
        CGFloat offSetY = currentCell.center.y - (_leftTablew.frame.size.height * 0.5);
        
        if (offSetY < 0) {
            offSetY = 0;
        }
        
        //最大偏移量
        CGFloat maxOffSetY = _leftTablew.contentSize.height - _leftTablew.frame.size.height;
        
        if (maxOffSetY < 0) {
            maxOffSetY = 0;
        }
        
        if (offSetY > maxOffSetY) {
            offSetY = maxOffSetY;
        }
        
        [self.leftTablew setContentOffset:CGPointMake(0.0, offSetY) animated:YES];

    }
    
}
@end




