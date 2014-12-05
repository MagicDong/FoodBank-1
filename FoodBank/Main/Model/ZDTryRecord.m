//
//  ZDTryRecord.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/4.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTryRecord.h"

@implementation ZDTryRecord

- (id)initWithTryRecordDict:(NSDictionary *)dict;
{
//    {"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-02","introduce":"","isTrying":1,"grams":10,"micon":""}
    self = [super init];
    if (self) {
        _mname     = dict[@"mname"];
        _cycle     = dict[@"cycle"];
        _practice  = dict[@"practice"];
        _tryDate   = dict[@"tryDate"];
        _introduce = dict[@"introduce"];
        _isTrying  = dict[@"isTrying"];
        _grams     = dict[@"grams"];
        _micon     = dict[@"micon"];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithTryRecordDict:dict];
}

@end
