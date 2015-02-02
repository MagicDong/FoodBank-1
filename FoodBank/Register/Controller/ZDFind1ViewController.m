//
//  ZDFind1ViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 15/1/28.
//  Copyright (c) 2015年 Dong. All rights reserved.
//

#import "ZDFind1ViewController.h"
#import "UIView+Add.h"
#import "MBProgressHUD+ZD.h"
#import "ZDNetwork.h"
#import "ZDBaby.h"
#import "ZDBabyTool.h"
#import "ZDFind2ViewController.h"
#import <SMS_SDK/SMS_SDK.h>
@interface ZDFind1ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *yanzheng;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ZDFind1ViewController
int timerCount = 99;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
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

- (IBAction)yanzhegnma:(UIButton *)sender {
    if ([self isValidateMobile:self.phoneNumber.text]) {
        self.yanzhengma.enabled = NO;
        [MBProgressHUD showSuccess:@"获取验证码成功"];
        [SMS_SDK getVerifyCodeByPhoneNumber:self.phoneNumber.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self.timer fire];
        });
    }else{
        [MBProgressHUD showError:@"手机号码不正确"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self.phoneNumber setText:nil];
            [self.phoneNumber resignFirstResponder];
        });
        return;
    }
}

- (IBAction)queding:(UIButton *)sender {


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
    [self.yanzhengma setTitle:[NSString stringWithFormat:@"%d 秒",timerCount] forState:UIControlStateNormal];
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
    [self.yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    self.huoquyanzheng.titleLabel.font = [UIFont systemFontOfSize:15];
    self.yanzhengma.enabled = YES;
    
}

- (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end
