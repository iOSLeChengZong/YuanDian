//
//  CategoryViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryViewModel.h"

@implementation CategoryViewModel
//左侧tableView
-(NSInteger)rowNumber{
    return self.categoryModels.count;
}

-(NSString *)tableViewFroTitleForRowForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    return self.categoryModels[indexPath.row].menuName;
}

//右侧collectionView
-(NSInteger)collectionViewForSectionNumber:(NSInteger)tableVIndex{
    return self.categoryModels[tableVIndex].topMenu.count;
}

-(NSInteger)collectionViewForRowNumberForSection:(NSInteger)section tableViewIndex:(NSInteger)index{
    return self.categoryModels[index].topMenu[section].typeMenu.count;
}

-(NSString *)collectionViewForTitleForSection:(NSInteger)section tableViewIndex:(NSInteger)index{
    return  self.categoryModels[index].topMenu[section].topName;
}


-(NSString *)collectionViewForTitleForRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section tableViewIndex:(NSInteger)index{
    return self.categoryModels[index].topMenu[section].typeMenu[indexPath.row].typeName;
}

-(NSString *)collectionViewForImageNameForRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section tableViewIndex:(NSInteger)index{
    return self.categoryModels[index].topMenu[section].typeMenu[indexPath.row].typeImg;
}


-(void)getCategoryDataCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [PlistDataManager getCategoryData:^(NSArray<CategoryModel *> *categoryData, NSError * _Nonnull error) {
        self.categoryModels = categoryData;
        completionHandler(error);
    }];
}
@end
