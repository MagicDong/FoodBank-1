//
//  ZDNewFood.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/4.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"mname":"芒果","practice":"","pgtpid":42,"introduce":"","mid":558}
@interface ZDNewFood : NSObject
@property (nonatomic , copy  ) NSString *mname;
@property (nonatomic , copy  ) NSString *zzgc;
@property (nonatomic , copy  ) NSString *pgtpid;
@property (nonatomic , copy  ) NSString *introduce;
@property (nonatomic , copy  ) NSString *mid;

- (id)initWithNewFoodDict:(NSDictionary *)dict;
+ (id)initWithDict:(NSDictionary *)dict;


@end
