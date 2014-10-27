//
//  ZDTuiJianViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-9.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTuiJianViewController.h"

@interface ZDTuiJianViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *zhouqi;
@property (weak, nonatomic) IBOutlet UILabel *keshu;

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

- (IBAction)isOK:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setFoodInfo:(NSDictionary *)foodInfo{
    _foodInfo = foodInfo;
    self.foodName.text = foodInfo[@"foodName"];
    self.zhouqi.text = foodInfo[@"zhouqi"];
    self.keshu.text = foodInfo[@"keshu"];
}


@end
