//
//  ZDEditViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZDEditDelegate <NSObject>

@optional

- (void)didSelectedMid:(NSString *)mid;

@end


@interface ZDEditViewController : UIViewController

@property (nonatomic,weak) id<ZDEditDelegate> delegate;

@end
