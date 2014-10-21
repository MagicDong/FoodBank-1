//
//  ZDMoreView.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-17.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBorderView.h"
@class ZDMoreView;


@protocol ZDMoreViewDelegate <NSObject>

- (void)moreViewDidOK:(ZDMoreView *)moreView;
/**
 *  加号按钮被点击时通知代理的方法
 */
- (void)moreViewDidWWW:(ZDMoreView *)moreView;

@end

@interface ZDMoreView : LBorderView

+ (instancetype)moreView;

@property (nonatomic, weak) id<ZDMoreViewDelegate>  delegate;

@end
