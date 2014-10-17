//
//  ZDMoreView.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-17.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDMoreView.h"

@implementation ZDMoreView

+ (instancetype)moreView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDMoreView" owner:nil options:nil] lastObject];
}



@end
