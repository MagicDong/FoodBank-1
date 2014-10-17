//
//  ZDNavViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNavViewController.h"

@interface ZDNavViewController ()

@end

@implementation ZDNavViewController

+ (void)initialize
{
    //    IWLog(@"initialize");
    // 1.设置导航条的主题
    [self setupNavTheme];
    
    // 2.设置按钮的主题
    [self setupButtonTheme];
    
}
/**
 *  设置按钮的主题
 */
+ (void)setupButtonTheme
{
    // 1.拿到主题对象
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 2.设置属性
    if (!iOS7) {
        // 2.1设置按钮的背景图片
        [item setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    // 3设置按钮的文字属性
    // 3.1设置默认状态下的文字属性
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[UITextAttributeTextColor] = [UIColor orangeColor];
    md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    md[UITextAttributeFont] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:md forState:UIControlStateNormal];
    
    // 3.2设置高亮状态下的文字属性
    NSMutableDictionary *mdHig = [NSMutableDictionary dictionaryWithDictionary:md];
    mdHig[UITextAttributeTextColor] = [UIColor redColor];
    [item setTitleTextAttributes:mdHig forState:UIControlStateHighlighted];
    
    // 3.2设置高亮状态下的文字属性
    NSMutableDictionary *mddisabled = [NSMutableDictionary dictionaryWithDictionary:md];
    mddisabled[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:mddisabled forState:UIControlStateDisabled];
}
/**
 *  设置导航条的主题
 */
+ (void)setupNavTheme
{
    // 1.1.拿到appearance主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 1.2设置主题
    if (!iOS7) {
        // 1.设置导航条背景图片
        [navBar setBackgroundImage:[UIImage imageWithNamed:@"Judge2"] forBarMetrics:UIBarMetricsDefault];
        
        // 2.设置导航条标题的属性
        NSMutableDictionary *md = [NSMutableDictionary dictionary];
        // 文字颜色
        md[UITextAttributeTextColor] = [UIColor blackColor];
        // 文字偏移位
        md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
        // 文字字体大小
        md[UITextAttributeFont] = [UIFont systemFontOfSize:20];
        [navBar setTitleTextAttributes:md];
    }
    // 1.设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageWithNamed:@"Judge2"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.设置导航条标题的属性
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    // 文字颜色
    md[UITextAttributeTextColor] = [UIColor whiteColor];
    // 文字偏移位
    md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    // 文字字体大小
    md[UITextAttributeFont] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:md];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 1.只有栈中有控制器的情况才需要隐藏工具条
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 2.覆盖返回按钮
        // 只要覆盖了返回按钮, 系统自带的拖拽返回上一级的功能就会失效
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        
        // 3.添加更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    // 第一次(根控制器)不需要隐藏工具条
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
