//
//  ZDJudgeViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-25.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDJudgeViewController.h"
#import "ZDNotifyViewController.h"
#import "ZDSupViewController.h"

@interface ZDJudgeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fuhe;
@property (weak, nonatomic) IBOutlet UIButton *bufuhe;

@end

@implementation ZDJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"辅食添加";
    [self.fuhe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bufuhe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}
- (IBAction)fuhe:(id)sender {
    ZDSupViewController *sup = [[ZDSupViewController alloc]init];
    [self.navigationController pushViewController:sup animated:YES];
}

- (IBAction)bufuhe:(id)sender {
    ZDNotifyViewController *not = [[ZDNotifyViewController alloc]init];
    [self.navigationController pushViewController:not animated:YES];
}

@end
