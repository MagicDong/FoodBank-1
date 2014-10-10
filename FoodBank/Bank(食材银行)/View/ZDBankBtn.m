//
//  ZDBankBtn.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-9.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDBankBtn.h"

@implementation ZDBankBtn

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return self;
}

@end
