//
//  PersonalViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalNoneLogonHeader.h"
#import "PersonalLogonHeader.h"
#import "PersonCollectionViewCell.h"
#import "MyGoldViewController.h"
#import "MyTeacherViewController.h"
#import "PersonalSystemMessageViewController.h"
#import "PersonalEditorDataViewController.h"

#define kPersonalNoneLogonHeader @"PersonalNoneLogonHeader"
#define kPersonalLogonHeader @"PersonalLogonHeader"
#define kPersonCollectionViewCell @"PersonCollectionViewCell"


@interface PersonalViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *personalCollectionView;
@property (nonatomic,strong) NSArray *cellImageNames;

@end

@implementation PersonalViewController

#pragma mark -- 懒加载
-(NSArray *)cellImageNames{
    if (!_cellImageNames) {
        _cellImageNames = @[@"y_p_我的金币icon",@"y_p_我的导师icon",@"y_p_服务中心",@"y_p_邀请有礼icon",@"y_p_系统设置icon"];
    }
    return _cellImageNames;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self registerCell];
    
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,---%ld",[self class],indexPath.row);
    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
        MyGoldViewController *goldVC = [storyboard instantiateViewControllerWithIdentifier:@"MyGoldViewController"];
        [self.navigationController pushViewController:goldVC animated:YES];
    }
    
    else if (indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
        MyTeacherViewController *teacherVC = [storyboard instantiateViewControllerWithIdentifier:@"MyTeacherViewController"];
        [self.navigationController pushViewController:teacherVC animated:YES];
    }
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonCollectionViewCell *cell = [self.personalCollectionView dequeueReusableCellWithReuseIdentifier:kPersonCollectionViewCell forIndexPath:indexPath];
    cell.nameImage.image = [UIImage imageNamed:self.cellImageNames[indexPath.row]];
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PersonalLogonHeader *header = [self.personalCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalLogonHeader forIndexPath:indexPath];
    
    
    [header addClickHandler:^(PersonalLogonHeaderClick click) {
        NSLog(@"在这里完成消息界面跳转");
        
        if (click == PersonalLogonHeaderClickMessage) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
            PersonalSystemMessageViewController *systemMeVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalSystemMessageViewController"];
            [self.navigationController pushViewController:systemMeVC animated:YES];
            
        }
        
        if (click == PersonalLogonHeaderClickEditor) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
            PersonalEditorDataViewController *editorVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalEditorDataViewController"];
            [self.navigationController pushViewController:editorVC animated:YES];
        }
        
    }];
    CGRect frame = header.frame;
    frame.origin.y -= STATUS_BAR_HEIGHT;
    header.frame = frame;
    return header;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW, 56);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(-STATUS_BAR_HEIGHT + 6, 0, 3, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, 326);
}


#pragma mark -- 方法
-(void)registerCell{
    [self.personalCollectionView registerNib:[UINib nibWithNibName:kPersonalNoneLogonHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalNoneLogonHeader];
    [self.personalCollectionView registerNib:[UINib nibWithNibName:kPersonalLogonHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalLogonHeader];
    [self.personalCollectionView registerNib:[UINib nibWithNibName:kPersonCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kPersonCollectionViewCell];
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
