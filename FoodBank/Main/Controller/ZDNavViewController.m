//
//  ZDNavViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//
#import "ZDNavViewController.h"
#import "ZDTryChooseButton.h"
#import "ZDTuiJianViewController.h"
#import "ZDEditViewController.h"
#import "ZDMoreView.h"

@interface ZDNavViewController ()
/**
 *  蒙板
 */
@property (nonatomic, strong)UIButton *cover;
/**
 *  时间选择
 */
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@property (nonatomic,strong) UIWebView *webView;
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
- (void)more{
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
            //            self.moreView.y = self.moreView.y - self.moreView.height;
            [self.cover setAlpha:0];
            [self.moreView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
            [self.cover removeFromSuperview];
            self.xiala = NO;
        }];
        return;
    }else{
        // 1.添加按钮蒙板
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = self.view.window.frame;
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
        cover.userInteractionEnabled = YES;
        // 控制UIButton的透明度
        [cover setAlpha: 0.0];
        [self.moreView setAlpha:0];
        self.cover = cover;
        [self.view.window addSubview:cover];
        [self.view.window bringSubviewToFront:self.moreView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.moreView setAlpha:1];
            [self.cover setAlpha: 0.65];
            // 监听蒙板点击事件
        } completion:^(BOOL finished) {
            self.xiala = YES;
        }];
        return;
    }
}
- (void)smallImage{
    
}

#pragma mark - 懒加载
- (ZDMoreView *)moreView{
    if (!_moreView) {
        _moreView = [ZDMoreView moreView];
        self.moreView.y = self.moreView.y - self.moreView.height;
        self.moreView.center = self.view.center;
        self.moreView.borderType = BorderTypeDashed;
        self.moreView.dashPattern = 2;
        //    self.moreView.spacePattern = 2;
        self.moreView.borderWidth = 1;
        self.moreView.cornerRadius = 10;
        self.moreView.borderColor = [UIColor redColor];
        self.moreView.backgroundColor = ZDColor(255, 246, 229)
        self.moreView.delegate = self;
        [self.view.window  addSubview:_moreView];
    }
    return _moreView;
}
- (void)moreViewDidOK:(ZDMoreView *)moreView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.cover setAlpha:0];
        [self.moreView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.moreView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.xiala = NO;
    }];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}

- (void)moreViewDidWWW:(ZDMoreView *)moreView{
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
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


@end
