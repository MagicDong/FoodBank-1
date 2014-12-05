//
//  ZDNewFood.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/4.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNewFood.h"

@implementation ZDNewFood

//@property (nonatomic , copy  ) NSString *mname;
//@property (nonatomic , copy  ) NSString *practice;
//@property (nonatomic , copy  ) NSString *pgtpid;
//@property (nonatomic , copy  ) NSString *introduce;
//@property (nonatomic , copy  ) NSString *mid;

- (id)initWithNewFoodDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        _mname = dict[@"mname"];
        _practice = dict[@"practice"];
        _pgtpid = dict[@"pgtpid"];
        _introduce = dict[@"introduce"];
        _mid = dict[@"mid"];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithNewFoodDict:dict];
}

@end
