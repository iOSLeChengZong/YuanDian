//
//  NSObject+Parse.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "NSObject+Parse.h"
#import "YYModel.h"

@implementation NSObject (Parse)
+(id)parse:(id)responseObj{
    
    //字典类型
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self yy_modelWithJSON:responseObj];
    }
    
    //数组类型
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[self class] json:responseObj];
    }
    //即不是字典也不是数组
    return responseObj;
}

@end
