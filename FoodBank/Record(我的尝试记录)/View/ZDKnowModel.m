//
//  ZDKnowModel.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowModel.h"

@implementation ZDKnowModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    ZDKnowModel *m = [[ZDKnowModel alloc] init];
    m.title = dict[@"title"];
    m.detail = dict[@"detail"];
    m.height = 44;
    return m;
}

+ (instancetype)model:(NSInteger)row detail:(NSString *)detail
{
    ZDKnowModel *m = [[ZDKnowModel alloc] init];
    m.detail = detail;
    m.notClick = YES;
    m.height = 180;
    return m;
}
@end
