//
//  CZProduct.m
//  04-UICollectionView
//
//  Created by LNJ on 14-6-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZProduct.h"

@implementation CZProduct

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)products
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"products.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    // 循环建立产品数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self productWithDict:dict]];
    }
    
    return arrayM;
}

@end
