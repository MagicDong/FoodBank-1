//
//  ZDRgsViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-23.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRgsViewController.h"
#import "ZDDatePickerView.h"

@interface ZDRgsViewController () 

@end

@implementation ZDRgsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
}

@end
