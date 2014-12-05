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
#import "ZDInitViewController.h"
#import "ZDBaby.h"
#import "ZDBabyTool.h"
#import <SMS_SDK/SMS_SDK.h>
#import "ZDNetwork.h"

@interface ZDRgsViewController ()

/**
 *  时间选择
 */
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;

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
    self.yanzheng.layer.borderWidth = 1;
    UIColor *color = ZDColor(114, 208, 96);
    self.yanzheng.layer.borderColor = [color CGColor];
    [UIApplication sharedApplication].statusBarHidden = NO;
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
    [self.huoquyanzheng setTitle:[NSString stringWithFormat:@"%d 秒",timerCount] forState:UIControlStateNormal];
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
    
//    if ([self isValidateMobile:self.userName.text]) {
    if ((1)) {
        self.huoquyanzheng.enabled = NO;
        [MBProgressHUD showSuccess:@"获取验证码成功"];
        [SMS_SDK getVerifyCodeByPhoneNumber:self.userName.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
            
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self.timer fire];
        });
    }else{
        [MBProgressHUD showError:@"手机号码不正确"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self.userName setText:nil];
            [self.userName resignFirstResponder];
        });
        return;
    }

}

- (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

- (IBAction)zhuce:(UIButton *)sender {
    
    [ZDNetwork registerWithPhone:self.userName.text Password:self.password.text Callback:^(RspState *rsp) {
        NSLog(@"%d",rsp.rspCode);
        if (rsp.rspCode == 0) {
            [MBProgressHUD showSuccess:@"注册成功"];
            //     注册成功后
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                //        [self dismissViewControllerAnimated:YES completion:nil];

                [ZDNetwork LoginWithPhone:self.userName.text Password:self.password.text Callback:^(RspState *rsp,NSString *jsessionid) {
                    if (rsp.rspCode == 0) {
                        ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
                        ZDBaby *baby = [[ZDBaby alloc]init];
                        baby.userName = self.userName.text;
                        baby.password = self.password.text;
                        baby.jsessionid = jsessionid;
                        [babyTool saveAccount:baby];
                        // 进入初始化界面
                        ZDInitViewController *initView = [[ZDInitViewController alloc]init];
                        [self.navigationController pushViewController:initView animated:YES];
                    }
                }];
            });
        }
    }];
    
//    if (self.password.text.length >= 6  && ([self.password.text isEqualToString:self.password2.text]) && self.password.text.length < 16) {
//        [SMS_SDK commitVerifyCode:self.yanzheng.text result:^(enum SMS_ResponseState state) {
//            if (state == SMS_ResponseStateFail) {
//                [MBProgressHUD showError:@"验证码有误！"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [MBProgressHUD hideHUD];
//                });
//                return ;
//            }else{
//                [ZDNetwork registerWithPhone:self.userName.text Password:self.password.text Callback:^(RspState *rsp) {
//                    if (rsp.rspCode == 0) {
//                        [MBProgressHUD showSuccess:@"注册成功"];
//                        //     注册成功后
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [MBProgressHUD hideHUD];
//                            //        [self dismissViewControllerAnimated:YES completion:nil];
//                            ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
//                            ZDBaby *baby = [[ZDBaby alloc]init];
//                            baby.userName = self.userName.text;
//                            baby.password = self.password.text;
//                            [babyTool saveAccount:baby];
//                            // 进入初始化界面
//                            ZDInitViewController *initView = [[ZDInitViewController alloc]init];
//                            [self.navigationController pushViewController:initView animated:YES];
//                        });
//                    }
//                }];
//            }
//        }];
//    }else{
//        [MBProgressHUD showError:@"用户名或密码有误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//        });
//    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
