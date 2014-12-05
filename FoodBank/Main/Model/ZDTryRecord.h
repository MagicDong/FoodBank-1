//
//  ZDTryRecord.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/4.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDTryRecord : NSObject

@property (nonatomic , copy  ) NSString *mname;
@property (nonatomic , copy  ) NSString *cycle;
@property (nonatomic , copy  ) NSString *practice;
@property (nonatomic , copy  ) NSString *tryDate;
@property (nonatomic , copy  ) NSString *introduce;
@property (nonatomic , copy  ) NSString *isTrying;
@property (nonatomic , copy  ) NSString *grams;
@property (nonatomic , copy  ) NSString *micon;


- (id)initWithTryRecordDict:(NSDictionary *)dict;
+ (id)initWithDict:(NSDictionary *)dict;

@end
