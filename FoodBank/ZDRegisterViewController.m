//
//  RegisterViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRegisterViewController.h"
#import "ZDSearchBar.h"
#import "MBProgressHUD+ZD.h"
#import "ZDTabBarController.h"
#import "ZDHttpTool.h"
#import "ZDAccountTool.h"
#import "ZDAccount.h"
#import "UIView+Add.h"
#import "ZDNavViewController.h"
#import "ZDRgsViewController.h"
#import "ZDNewfeatureViewController.h"
#import "ZDInitViewController.h"
#import "ZDNavViewController.h"
#import "ZDChooseButton.h"
#import "ZDNetwork.h"
#import "ZDBaby.h"
#import "ZDBabyTool.h"

@interface ZDRegisterViewController () <UIWebViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ZDChooseButton *zidong;
@property (weak, nonatomic) IBOutlet ZDChooseButton *jizhu;
@property (weak, nonatomic) IBOutlet ZDSearchBar *user;
@property (weak, nonatomic) IBOutlet ZDSearchBar *pwd;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *rgs;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

@implementation ZDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

/** 登录按钮 */
- (IBAction)login:(UIButton *)sender {
    
    if(self.user.text.length == 0){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(self.user.text.length != 11){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(self.pwd.text.length  == 0){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(self.pwd.text.length < 6){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    [ZDNetwork LoginWithPhone:self.user.text Password:self.pwd.text Callback:^(RspState *rsp,NSString *jsessionid) {
        if (rsp.rspCode == 0) {
            
            ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
            ZDBaby *baby = [[ZDBaby alloc]init];
            baby.userName = self.user.text;
            baby.password = self.pwd.text;
            baby.jsessionid = jsessionid;
            [babyTool saveAccount:baby];
            
            ZDTabBarController *tabbar = [[ZDTabBarController alloc] init];
            UIApplication *app = [UIApplication sharedApplication];
            UIWindow *window = app.keyWindow;
            app.statusBarHidden = NO;
            window.rootViewController = tabbar;
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }];
    
//    // 发送网络请求判断是否需要初始化
//    if((0)){
//        ZDInitViewController *chushihua = [[ZDInitViewController alloc] init];
//        ZDNavViewController *nav = [[ZDNavViewController alloc]initWithRootViewController:chushihua];
//        UIApplication *app = [UIApplication sharedApplication];
//        UIWindow *window = app.keyWindow;
//        app.statusBarHidden = NO;
//        window.rootViewController = nav;
//    }else{
//
//    }
    
}

- (IBAction)rgs:(UIButton *)sender {
    ZDRgsViewController *tabBarVc = [[ZDRgsViewController alloc] init];
    ZDNavViewController *nav = [[ZDNavViewController alloc]initWithRootViewController:tabBarVc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
//    [self.navigationController pushViewController:tabBarVc animated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITextField *textField =  [UIView findFistResponder:self.view];
    [textField resignFirstResponder];
    
}

///**
// *  当webView开始加载时 调用第三方框架 提示用户正在加载中...
// */
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [MBProgressHUD showMessage:@"正在加载中..."];
//}
//
///**
// *  当webView完成加载时 隐藏提示框
// */
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [MBProgressHUD hideHUD];
//}
//
///**
// *  加载失败时
// */
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [MBProgressHUD hideHUD];
//}

@end
