//
//  ZDYueZongJie.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/5.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDYueZongJie : NSObject
//reserves={"1":3,"6":1}
//reject=0
//secure=4
//month={"1":4}
//allergy=0
@property (nonatomic , strong) NSDictionary *reserves;
@property (nonatomic , assign) int reject;
@property (nonatomic , assign) int secure;
@property (nonatomic , strong) NSDictionary *month;
@property (nonatomic , assign) int allergy;


- (id)initWithYueZongJieDict:(NSDictionary *)dict;
+ (id)initWithDict:(NSDictionary *)dict;

@end
