//
//  RspState.m
//  mRescue
//
//  Created by mhealth on 14-8-28.
//  Copyright (c) 2014年 IVT. All rights reserved.
//

#import "RspState.h"

@implementation RspState



- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _rspCode = [dict[@"errorCode"] intValue];
        _rspMsg = dict[@"errorMsg"];
    }
    return self;
}


-(NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"Response code %d Detail %@",_rspCode,_rspMsg];
    return string;
}


+ (id)rspStateNetError
{
    NSDictionary *dict = @{@"errorCode": @1001,
                           @"errorMsg":@"网络错误",
                           };
    
    return [[RspState alloc]initWithDict:dict ];
    
}

+ (id)rspStateLoginError
{
    NSDictionary *dict = @{@"errorCode": @1002,
                           @"errorMsg":@"该功能需要先登录",
                           };
    
    return [[RspState alloc]initWithDict:dict ];
    
}

@end
