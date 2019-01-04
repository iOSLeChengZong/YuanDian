//
//  PersonalLogonHeader.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PersonalLogonHeaderClick) {
    PersonalLogonHeaderClickMessage,
    PersonalLogonHeaderClickEditor,
};

NS_ASSUME_NONNULL_BEGIN

@interface PersonalLogonHeader : UICollectionReusableView
@property(nonatomic,copy) void(^personalClickHander)(PersonalLogonHeaderClick);
-(void)addClickHandler:(void(^)(PersonalLogonHeaderClick click))handler;

@end

NS_ASSUME_NONNULL_END
