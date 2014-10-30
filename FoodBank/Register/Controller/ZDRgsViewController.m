//
//  ZDRgsViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-23.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRgsViewController.h"
#import "UIView+Add.h"
#import "MBProgressHUD+ZD.h"
#import "ZDChooseButton.h"

@interface ZDRgsViewController ()

/**
 *  时间选择
 */

@property (weak, nonatomic) IBOutlet UITextField *yanzheng;
@property (weak, nonatomic) IBOutlet UIButton *huoquyanzheng;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ZDRgsViewController
int timerCount = 99;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *textFiel =  [UIView findFistResponder:self.view];
    [textFiel resignFirstResponder];
    return YES;
}

- (void)timerFire
{
    timerCount--;
    [self.huoquyanzheng setTitle:[NSString stringWithFormat:@"%d",timerCount] forState:UIControlStateNormal];
//    self.huoquyanzheng.titleLabel.text = [NSString stringWithFormat:@"%d",timerCount];
//    self.huoquyanzheng.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (timerCount == 0) {
        [self timerColsed];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    timerCount = 99;
    
}
- (void)timerColsed
{
    [self.timer invalidate];
    self.timer = nil;
    timerCount = 99;
     [self.huoquyanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
//    self.huoquyanzheng.titleLabel.font = [UIFont systemFontOfSize:15];
    self.huoquyanzheng.enabled = YES;
}

- (IBAction)huoquyanzheng:(UIButton *)sender {
    self.huoquyanzheng.enabled = NO;
    [MBProgressHUD showSuccess:@"获取验证码成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self.timer fire];
    });
}

- (IBAction)zhuce:(UIButton *)sender {
     [MBProgressHUD showSuccess:@"注册成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    UITextField *textField =  [UIView findFistResponder:self.view];
//    [textField resignFirstResponder];
}

@end
