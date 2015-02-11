//
//  ZDSiKuViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDEditDelegate <NSObject>

@optional

- (void)didSelectedMid:(NSDictionary *)mid;

@end

@interface ZDEditController : UIViewController

@property (nonatomic,weak) id<ZDEditDelegate> delegate;

@end
