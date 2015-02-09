//
//  ZDYueViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDYueViewController.h"
#import "ZDBankBtn.h"

@interface ZDYueViewController ()

@end

@implementation ZDYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"月总结";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
}


@end
