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
#import <TencentOpenAPI/TencentOAuth.h>

@interface ZDRegisterViewController () <UIWebViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ZDSearchBar *user;
@property (weak, nonatomic) IBOutlet ZDSearchBar *pwd;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *rgs;
@property (weak, nonatomic) IBOutlet UIView *other;
@property (weak, nonatomic) IBOutlet UIButton *qq;
@property (weak, nonatomic) IBOutlet UIButton *sina;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

@implementation ZDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIImage *image = [UIImage imageWithNamed:@"ipad_user_three_login"];
    self.other.backgroundColor = [UIColor colorWithPatternImage:image];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    [self initTencent];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *textFiel =  [UIView findFistResponder:self.view];
    [textFiel resignFirstResponder];
    return YES;
}

/** 登录按钮 */
- (IBAction)login:(UIButton *)sender {
    if(self.user.text.length== 0 || self.pwd.text.length == 0 || self.pwd.text.length < 6){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(self.pwd.text.length < 6){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(self.user.text.length < 3){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    // 跳转到TabBarController
    ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    app.statusBarHidden = NO;
    window.rootViewController = tabBarVc;
}

- (IBAction)rgs:(UIButton *)sender {
    ZDRgsViewController *tabBarVc = [[ZDRgsViewController alloc] init];
    [self.navigationController pushViewController:tabBarVc animated:YES];
}

- (IBAction)qq:(UIButton *)sender {
    [self QQLogin];
}

- (IBAction)sina:(UIButton *)sender {
    [self weiboLogin];
}

- (void)QQLogin
{

    // 设置用户需要授权的信息参数
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t",@"get_simple_user_info",nil];
    [_tencentOAuth authorize:permissions inSafari:NO];
}

- (void)initTencent
{
    /** 第三方应用在开发过程中设置的URLSchema，用于浏览器登录后后跳到第三方应用 */
    // 1101995550
//    NSString *appid = @"1101995550";
//    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"222222" andDelegate:self];
}


- (void)tencentDidLogin
{
    _labelTitle.text = @"登录完成";
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        _labelAccessToken.text = _tencentOAuth.accessToken;
        /** 获取用户信息 */
        if ([_tencentOAuth getUserInfo]) {
            ZDLog(@"获取用户信息成功");
        }else{
            ZDLog(@"获取用户信息失败");
        }
        [_tencentOAuth setAccessToken:[_tencentOAuth accessToken]] ;
        [_tencentOAuth setOpenId:[_tencentOAuth openId]] ;
        [_tencentOAuth setExpirationDate:[_tencentOAuth expirationDate]] ;
    }
    else
    {
        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}

/** 代理自动调用，获取用户信息 */
- (void)getUserInfoResponse:(APIResponse *)response
{
    [self saveAccount:response.jsonResponse];
    ZDTabBarController *root = [[ZDTabBarController alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    windows.rootViewController = root;
}

/** 保存用户信息 */
- (void)saveAccount:(NSDictionary *)respones
{
    NSDictionary *dict = respones;
    ZDAccount *account = [[ZDAccount alloc]init];
    account.nickname = dict[@"nickname"];
    account.city = dict[@"city"];
    account.figureurl_qq_1 = dict[@"figureurl_qq_1"];
    account.figureurl_qq_2 = dict[@"figureurl_qq_2"];
    account.gender = dict[@"gender"];
    [ZDAccountTool saveAccount:account];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)weiboLogin
{
    self.view = [[UIWebView alloc]init];
    // 获取当前webView
    UIWebView *webView = (UIWebView *)self.view;
    // 获取固定格式的URL地址 传入客户ID和回调地址
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",ZDAppKey,ZDAppRedirectUrl];
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    // 设置webView的代理
    webView.delegate = self;
    // 通过url实例化一个URL请求
    NSURLRequest *relRequest = [[NSURLRequest alloc]initWithURL:url];
    // 让webView加载URL请求
    [webView loadRequest:relRequest];
}

/**
 *  每次发送请求都会调用次方法
 *
 *  @param request  URL请求
 *
 *  @return 返回YES允许此次请求,返回NO不允许此次请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.判断请求的request中是否包含code= ,如果保护code=就将code取出, 利用code去获取access token  如果不包含 ==0  表示此次请求不成功 有问题
    // 1.通过请求的URL获取 请求的绝对字符串
    NSString *url = request.URL.absoluteString;
    // 2.检测URL字符串中是否包含 "code="
    // 包含表示请求认证通过,可以利用code去获取access_token
    NSRange range = [url rangeOfString:@"code="];
    // 判断是包含code=
    if (range.length != 0) {
        // 包含则截取出code=  之后的所有字符串
        NSString *code = [url substringFromIndex:NSMaxRange(range)];
        // 通过code字符串向服务器从新发送一个POST请求 获取授权信息
        [self accessTokenWithCode:code];
    }
    return YES;
}

/**
 *  根据已经授权的标记code  换取访问标记
 *
 *  @param code 已经授权的标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"client_id"] = ZDAppKey;
    parmas[@"client_secret"] = ZDAppSecret;
    parmas[@"grant_type"] = @"authorization_code";
    parmas[@"code"] = code;
    parmas[@"redirect_uri"] = ZDAppRedirectUrl;
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    // .keyValues第三方框架 模型转字典
    [ZDHttpTool postWithUrl:url params:parmas success:^(id json) {
        ZDAccount *account = [ZDAccount accountWithDict:json];
        [ZDAccountTool saveAccount:account];
        ZDTabBarController *root = [[ZDTabBarController alloc]init];
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *windows = app.keyWindow;
        windows.rootViewController = root;
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITextField *textField =  [UIView findFistResponder:self.view];
    [textField resignFirstResponder];
}

/**
 *  当webView开始加载时 调用第三方框架 提示用户正在加载中...
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

/**
 *  当webView完成加载时 隐藏提示框
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  加载失败时
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
