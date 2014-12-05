//
//  RspState.h
//  mRescue
//
//
//  Created by mhealth on 14-8-28.
//  Copyright (c) 2014年 IVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RspState : NSObject
@property (nonatomic, assign) int rspCode;
@property (nonatomic, copy) NSString *rspMsg;

+ (id)rspStateNetError;
+ (id)rspStateLoginError;
- (id)initWithDict:(NSDictionary *)dict;

@end
