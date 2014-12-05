//
//  ZDFoodCategory.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/3.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDFoodCategory.h"

@implementation ZDFoodCategory
- (id)initWithFoodGenreDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        _foodGenre = dict[@"foodGenre"];
        _foodGenreList = dict[@"foodGenreList"];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithFoodGenreDict:dict];
}

@end
