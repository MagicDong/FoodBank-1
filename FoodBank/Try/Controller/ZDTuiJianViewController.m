//
//  ZDTuiJianViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-9.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTuiJianViewController.h"

@interface ZDTuiJianViewController ()

@end

@implementation ZDTuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐做法";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}


@end
