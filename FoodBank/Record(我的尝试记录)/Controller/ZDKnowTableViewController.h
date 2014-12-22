//
//  ZDKnowTableViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDKnowDelegate <NSObject>

@optional

- (void)didClickCell:(NSInteger)to;

@end
typedef void (^didClickCell)(NSInteger resultType);

@interface ZDKnowTableViewController : UITableViewController

@property (nonatomic,weak) id<ZDKnowDelegate> knowDelegate;

@end
