//
//  AppDelegate.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "AppDelegate.h"
#import "ZDRegisterViewController.h"
#import "ZDTabBarController.h"
#import "ZDNewfeatureViewController.h"
#import "UIImageView+WebCache.h"
#import "ZDInitViewController.h"
#import "ZDNavViewController.h"
#import "ZDRegisterViewController.h"
#import "ZDBaby.h"
#import "ZDBabyTool.h"
#import "ZDNetwork.h"
#import "MBProgressHUD+ZD.h"
#import "UMSocial.h"
#import "ZDSpecialViewController.h"
//#import "MyUncaughtExceptionHandler.h"

@interface AppDelegate ()
@property (nonatomic , strong) UIImageView *imageView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([launchOptions[@"news"] isEqualToString:@"news"]) {
        ZDNewfeatureViewController *newfeature = [[ZDNewfeatureViewController alloc] init];
        self.window.rootViewController = newfeature;
        [self.window makeKeyAndVisible];
        return  YES;
    }
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    application.statusBarHidden = NO;
    
    // 短信注册KEY
//    APPKEY:  47f01de13458        AppSecret：   ec44a5b1ff4cb948cb16c1a0b1655b23
//    NSString *appKey = @"47f01de13458";
//    NSString *appSecret = @"ec44a5b1ff4cb948cb16c1a0b1655b23";
//    [SMS_SDK  registerApp:appKey withSecret:appSecret];
    
    // 设置友盟app key
    [UMSocialData setAppKey:@"5417d98ffd98c5661607aed9"];
    
    // 设置JPush推送
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置全局状态栏的颜色
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    // 判断显示新特性还是tabbarcontroller
    // 1.获取沙盒中的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = (__bridge_transfer NSString *)kCFBundleVersionKey;
    NSString *sandBoxVersion = [defaults valueForKey:key];
    
    
    // 2.获取当前软件的版本号
    NSDictionary *md =[NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = md[key];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //3.设置根控制器
//
     ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
//    BOOL tool = [ZDBabyTool sharedZDBabyTool].removeAccount;
    [UIApplication sharedApplication].statusBarHidden = YES;
    if ([currentVersion compare:sandBoxVersion] ==  NSOrderedDescending)
    {
        
        // 存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        // 第一次使用当前版本  --> 显示新特性界面
        ZDNewfeatureViewController *newfeature = [[ZDNewfeatureViewController alloc] init];
        self.window.rootViewController = newfeature;
        
        UIImageView *splashScreen = [[UIImageView alloc] initWithFrame:self.window.bounds];
        splashScreen.image = [UIImage imageNamed:@"LaunchImage-736h.png"];
        [self.window addSubview:splashScreen];
        
        [UIView animateWithDuration:1.6 animations:^{
            CATransform3D transform = CATransform3DMakeScale(1.6, 1.6, 1.0);
            splashScreen.layer.transform = transform;
            splashScreen.alpha = 0.0;
        } completion:^(BOOL finished) {
            [splashScreen removeFromSuperview];
        }];
    }else{
        //        ZDLog(@"%@",baby.userName);
//        if (baby.userName == nil) {
        if (0) {
            ZDRegisterViewController *reg = [[ZDRegisterViewController alloc]init];
            self.window.rootViewController = reg;
            UIImageView *splashScreen = [[UIImageView alloc] initWithFrame:self.window.bounds];
            splashScreen.image = [UIImage imageNamed:@"LaunchImage-736h.png"];
            [self.window addSubview:splashScreen];
            
            [UIView animateWithDuration:2.2 animations:^{
                CATransform3D transform = CATransform3DMakeScale(1.4, 1.4, 1.0);
                splashScreen.layer.transform = transform;
                splashScreen.alpha = 0.0;
            } completion:^(BOOL finished) {
                [splashScreen removeFromSuperview];
            }];
        }else{
            
            // 判断当前是否已经有登陆过的账号存在
//            ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
//            [ZDNetwork LoginWithPhone:baby.userName Password:baby.password Callback:^(RspState *rsp, NSString *jsessionid) {
//                if (rsp.rspCode == 0) {
            
            
                    ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
                    UIApplication *app = [UIApplication sharedApplication];
                    UIWindow *window = app.keyWindow;
                    app.statusBarHidden = NO;
                    window.rootViewController = tabBarVc;
                    [window makeKeyAndVisible];

            
//                }else{
//
//                    [MBProgressHUD showError:@"网络错误"];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [MBProgressHUD hideHUD];
//                    });
//                    
//                    ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
//                    UIApplication *app = [UIApplication sharedApplication];
//                    UIWindow *window = app.keyWindow;
//                    app.statusBarHidden = NO;
//                    window.rootViewController = tabBarVc;
//                    [window makeKeyAndVisible];
//                }
//            }];
    
            

//            ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
//            UIApplication *app = [UIApplication sharedApplication];
//            UIWindow *window = app.keyWindow;
//            app.statusBarHidden = NO;
//            window.rootViewController = tabBarVc;
//            [window makeKeyAndVisible];
            
            UIImageView *splashScreen = [[UIImageView alloc] initWithFrame:self.window.bounds];
            splashScreen.image = [UIImage imageNamed:@"LaunchImage-736h.png"];
            [self.window addSubview:splashScreen];
            
            [UIView animateWithDuration:1.6 animations:^{
                CATransform3D transform = CATransform3DMakeScale(1.6, 1.6, 1.0);
                splashScreen.layer.transform = transform;
                splashScreen.alpha = 0.0;
            } completion:^(BOOL finished) {
                [splashScreen removeFromSuperview];
            }];
        }
    }
    return YES;
}

//   异常处理
void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

// 当应用程序接收到内存警告的时候就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 应该在该方法中释放掉不需要的内存
    // 1.停止所有的子线程下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2.清空SDWebImage保存的所有内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
