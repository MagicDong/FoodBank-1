//
//  ZDMoreView.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-17.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBorderView.h"
@class ZDFoodCategory;


@protocol ZDMoreViewDelegate <NSObject>

- (void)foodPicker:(NSDictionary *)moreView;

@end

@interface ZDFoodPickerView : LBorderView

+ (instancetype)foodPickerView;

@property (nonatomic, weak) id<ZDMoreViewDelegate>  delegate;

@end
