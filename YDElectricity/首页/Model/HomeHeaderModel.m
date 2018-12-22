//
//	RootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeHeaderModel.h"


@implementation HomeHeaderModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows":[Row class]};
}

@end

@implementation Row
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"advertisementList":[AdvertisementList class],
             @"categoryClassList":[CategoryClassList class],
             @"goodsSpikeList":[GoodsSpikeList class]
             };
}

@end


//NSString *const kAdvertisementListAddTime = @"addTime";
//NSString *const kAdvertisementListEndTime = @"endTime";
//NSString *const kAdvertisementListIdField = @"id";
//NSString *const kAdvertisementListImgUrl = @"imgUrl";
//NSString *const kAdvertisementListJumpUrl = @"jumpUrl";
//NSString *const kAdvertisementListOrderBy = @"orderBy";
//NSString *const kAdvertisementListRemark = @"remark";
//NSString *const kAdvertisementListStartTime = @"startTime";
//NSString *const kAdvertisementListState = @"state";
//NSString *const kAdvertisementListTitle = @"title";
//NSString *const kAdvertisementListUpdateTime = @"updateTime";
@implementation AdvertisementList

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ID":@"id"};
}

@end


//NSString *const kCategoryClassListAddTime = @"add_time";
//NSString *const kCategoryClassListIdField = @"id";
//NSString *const kCategoryClassListName = @"name";
//NSString *const kCategoryClassListOrderBy = @"order_by";
//NSString *const kCategoryClassListOwnSector = @"own_sector";
//NSString *const kCategoryClassListRemark = @"remark";
//NSString *const kCategoryClassListState = @"state";
@implementation CategoryClassList

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"addTime":@"add_time",
             @"ID":@"id",
             @"orderBy":@"order_by",
             @"ownSector":@"own_sector"
             };
}



@end



//NSString *const kGoodsSpikeListAddTime = @"addTime";
//NSString *const kGoodsSpikeListCategoryName = @"categoryName";
//NSString *const kGoodsSpikeListClickUrl = @"clickUrl";
//NSString *const kGoodsSpikeListEndTime = @"endTime";
//NSString *const kGoodsSpikeListIsTop = @"isTop";
//NSString *const kGoodsSpikeListNumIid = @"numIid";
//NSString *const kGoodsSpikeListPageImgUrl = @"pageImgUrl";
//NSString *const kGoodsSpikeListPicUrl = @"picUrl";
//NSString *const kGoodsSpikeListReservePrice = @"reservePrice";
//NSString *const kGoodsSpikeListSoldNum = @"soldNum";
//NSString *const kGoodsSpikeListStartTime = @"startTime";
//NSString *const kGoodsSpikeListState = @"state";
//NSString *const kGoodsSpikeListTitle = @"title";
//NSString *const kGoodsSpikeListTotalAmount = @"totalAmount";
//NSString *const kGoodsSpikeListUpdateTime = @"updateTime";
//NSString *const kGoodsSpikeListZkFinalPrice = @"zkFinalPrice";
@implementation GoodsSpikeList


@end
