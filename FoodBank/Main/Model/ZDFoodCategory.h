//
//  ZDFoodCategory.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/3.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDFoodCategory : NSObject
//    {"foodGenre":"谷类","foodGenreList":[["1","面粉","面粉","谷类"],["8","婴幼儿面","面粉","谷类"]]}

@property (nonatomic , copy  ) NSString *foodGenre;
@property (nonatomic , strong) NSArray  *foodGenreList;

- (id)initWithFoodGenreDict:(NSDictionary *)dict;
+ (id)initWithDict:(NSDictionary *)dict;

@end
