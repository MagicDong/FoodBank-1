//
//  IWControllerTool.m
//
//  Created by apple on 14-7-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDControllerTool.h"
#import "ZDNewfeatureViewController.h"
#import "ZDTabBarController.h"
#import "ZDBabyTool.h"

@implementation ZDControllerTool


+ (void)chooseController
{
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
    
    //3.设置根控制器
    if ([currentVersion compare:sandBoxVersion] ==  NSOrderedDescending)
    {
        // 存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        // 第一次使用当前版本  --> 显示新特性界面
        ZDNewfeatureViewController *newfeature = [[ZDNewfeatureViewController alloc] init];
        window.rootViewController = newfeature;
        
    }else
    {
//        ZDBaby *baby = [ZDBabyTool account];
        // 1.显示状态栏
        app.statusBarHidden = NO;
        // 不是第一次使用当前版本 --> 显示TabBarController
        ZDTabBarController *tabBarVc =  [[ZDTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }
}
@end
