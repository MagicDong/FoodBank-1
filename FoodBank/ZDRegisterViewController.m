//
//  RegisterViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRegisterViewController.h"

@interface ZDRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *rgs;
@property (weak, nonatomic) IBOutlet UIView *other;
@property (weak, nonatomic) IBOutlet UIButton *qq;
@property (weak, nonatomic) IBOutlet UIButton *sina;


@end

@implementation ZDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝贝通行证";
}



@end
