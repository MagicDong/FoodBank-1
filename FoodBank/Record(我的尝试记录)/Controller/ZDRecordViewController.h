//
//  ZDRecordViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGPSegmentedController.h"


@class ZDTabBar;

@protocol ZDRecordDelegate <NSObject>

@optional

- (void)didSelectedButtonTo:(NSInteger)to;

@end


@interface ZDRecordViewController : UIViewController<YGPSegmentedControllerDelegate>
//- (IBAction)xxxxxx:(id)sender;
@property (nonatomic, weak) id<ZDRecordDelegate> recordDelegate;

@end
