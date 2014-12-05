//
//  ZDYueZongJie.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/5.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDYueZongJie.h"

@implementation ZDYueZongJie
- (id)initWithYueZongJieDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        _reserves     = dict[@"reserves"];
        _reject     = [dict[@"reject"] intValue];
        _secure  = [dict[@"secure"] intValue];
        _month = dict[@"month"];
        _allergy  = [dict[@"allergy"] intValue];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithYueZongJieDict:dict];
}

@end
