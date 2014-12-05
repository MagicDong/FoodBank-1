//
//  ZDZhouZongJie.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/5.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDZhouZongJie : NSObject
@property (nonatomic , strong) NSDictionary *reserves;
@property (nonatomic , assign) int reject;
@property (nonatomic , assign) int secure;
@property (nonatomic , strong) NSDictionary *week;
@property (nonatomic , assign) int allergy;


- (id)initWithZhouZongJieDict:(NSDictionary *)dict;
+ (id)initWithDict:(NSDictionary *)dict;
@end
