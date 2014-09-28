//
//  ZDNotifyViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-26.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNotifyViewController.h"

@interface ZDNotifyViewController ()

@end

@implementation ZDNotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"知识库";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}

- (IBAction)Finish:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
