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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置全局状态栏的颜色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if([launchOptions[@"news"] isEqualToString:@"news"]){
        self.window.rootViewController = [[ZDNewfeatureViewController alloc]init];
    }else{
        self.window.rootViewController = [[ZDNavViewController alloc]initWithRootViewController:[[ZDInitViewController alloc]init]];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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
