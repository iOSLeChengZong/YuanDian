//
//  CategoryViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewModel : NSObject
//根据UI
//左侧tableView
@property(nonatomic,assign) NSInteger rowNumber;
-(NSString *)tableViewFroTitleForRowForTableViewAtIndexPath:(NSIndexPath *)indexPath;

//右侧collectionVeiw
/** index 根据左侧talbeViewIndexPath.row来定 */
-(NSInteger)collectionViewForSectionNumber:(NSInteger)tableVIndex;
-(NSInteger)collectionViewForRowNumberForSection:(NSInteger)section tableViewIndex:(NSInteger)index;
-(NSString *)collectionViewForTitleForSection:(NSInteger)section tableViewIndex:(NSInteger)index;
-(NSString *)collectionViewForTitleForRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section tableViewIndex:(NSInteger)index;
-(NSString *)collectionViewForImageNameForRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section tableViewIndex:(NSInteger)index;


//根据接口
//模型层所有数据
@property(nonatomic,copy)NSArray<CategoryModel *> *categoryModels;
- (void)getCategoryDataCompletionHandler:(void(^)(NSError *error))completionHandler;



@end

NS_ASSUME_NONNULL_END
