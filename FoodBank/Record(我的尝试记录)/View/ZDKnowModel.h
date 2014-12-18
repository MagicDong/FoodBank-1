//
//  ZDKnowModel.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDKnowModel : NSObject


@property(copy,nonatomic)NSString * detail;

@property(copy,nonatomic)NSString * title;

@property(nonatomic,assign) BOOL open;

@property (nonatomic, assign) BOOL notClick;


// cell的高度
@property (nonatomic, assign) CGFloat height;

// 工厂方法：目的快速创建对象
+ (instancetype)modelWithDict:(NSDictionary *)dict;

+ (instancetype)model:(NSInteger)row detail:(NSString *)detail;
@end
