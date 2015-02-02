//
//  ZDSupViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-26.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSupViewController.h"
#import "ZDTabBarController.h"
#import "ZDSiKuViewController.h"

@interface ZDSupViewController ()

@end

@implementation ZDSupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"辅食添加";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
}

/** 已添加按钮 */
- (IBAction)tianjia:(id)sender {
    
    ZDSiKuViewController *siku = [[ZDSiKuViewController alloc]init];
    [self.navigationController pushViewController:siku animated:YES];
}

/** 未添加按钮 */
- (IBAction)weitianjia:(id)sender {
    // 跳转到TabBarController
    for (UIViewController *controller in self.childViewControllers) {
        // 将子视图控制器的视图从父视图中删除
        [controller.view removeFromSuperview];
        // 将视图控制器从父视图控制器中删除
        [controller removeFromParentViewController];
    }
    [self.view removeFromSuperview];
    ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    app.statusBarHidden = NO;
    window.rootViewController = tabBarVc;
}


@end
