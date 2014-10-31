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
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //3.设置根控制器
//    [currentVersion compare:sandBoxVersion] ==  NSOrderedDescending
    [UIApplication sharedApplication].statusBarHidden = YES;
    if ((0))
    {
        // 存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        // 第一次使用当前版本  --> 显示新特性界面
        ZDNewfeatureViewController *newfeature = [[ZDNewfeatureViewController alloc] init];
        window.rootViewController = newfeature;
        
    }else
    {
//        app.statusBarHidden = YES;
        ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
        if (baby.userName == nil) {
            self.window.rootViewController = [[ZDRegisterViewController alloc]init];
        }
//        app.statusBarHidden = NO;
        ZDTabBarController *tabBarVc =  [[ZDTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    // 应该在该方法中释放掉不需要的内存
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
