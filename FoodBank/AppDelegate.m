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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
//    APPKEY:  47f01de13458        AppSecret：   ec44a5b1ff4cb948cb16c1a0b1655b23
    NSString *appKey = @"47f01de13458";
    NSString *appSecret = @"ec44a5b1ff4cb948cb16c1a0b1655b23";
    [SMS_SDK    registerApp:appKey withSecret:appSecret];
    
     
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置全局状态栏的颜色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
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
    BOOL tool = [ZDBabyTool sharedZDBabyTool].removeAccount;
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    
//    if ([currentVersion compare:sandBoxVersion] ==  NSOrderedDescending)
    if (tool)
    {
        // 存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        // 第一次使用当前版本  --> 显示新特性界面
        ZDNewfeatureViewController *newfeature = [[ZDNewfeatureViewController alloc] init];
        self.window.rootViewController = newfeature;
        
    }else
    {
        ZDLog(@"%@",baby.userName);
        if (baby.userName == nil) {
            ZDRegisterViewController *reg = [[ZDRegisterViewController alloc]init];
            self.window.rootViewController = reg;
        }else{
            [UIApplication sharedApplication].statusBarHidden = NO;
            ZDTabBarController *tabBarVc =  [[ZDTabBarController alloc] init];
            self.window.rootViewController = tabBarVc;
        }
    }
    return YES;
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
