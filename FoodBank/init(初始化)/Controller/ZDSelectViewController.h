//
//  ZDSelectViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/24.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDSelectDelegate <NSObject>

- (void)selectFoodArray:(NSArray *)array;

@end

@interface ZDSelectViewController : UIViewController

@property (nonatomic,weak) id<ZDSelectDelegate> delegate;

@end
