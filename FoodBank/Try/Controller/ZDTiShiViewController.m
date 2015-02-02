//
//  ZDTiShiViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14/10/22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTiShiViewController.h"

@interface ZDTiShiViewController ()

@end

@implementation ZDTiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
}


@end
