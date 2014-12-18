//
//  ZDDataTool.h
//  IOSBaoDian
//
//  Created by Dong on 14-8-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDDataTool : NSObject


+ (NSArray *)dataWithSearch:(NSString *)text;
+ (NSInteger)dataWithClassID:(NSInteger)classid;
+ (NSInteger)dataWithCategoryID:(NSInteger)classid;
+ (NSInteger)dataWithClassID:(NSInteger)classid categoryID:(NSInteger)cotegoryid;

+ (NSArray *)dataWithStringClassID:(NSInteger)classid;
+ (NSArray *)dataWithStringCategoryID:(NSInteger)classid;
+ (NSArray *)dataWithStringClassID:(NSInteger)classid categoryID:(NSInteger)cotegoryid;
@end
