//
//  ZDJiLuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDJiLuViewController.h"

@interface ZDJiLuViewController ()

@end

@implementation ZDJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的尝试记录";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}

@end
