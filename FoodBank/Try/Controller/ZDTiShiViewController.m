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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
