//
//  ZDNavViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNavViewController.h"
#import "ZDTabBar.h"
#import "ZDTabBarButton.h"
#import "ZDRegisterViewController.h"
#import "ZDNavViewController.h"
#import "ZDMyBabyViewController.h"
#import "ZDBankViewController.h"
#import "ZDTryViewController.h"
#import "ZDNewsViewController.h"
#import "ZDRecordViewController.h"

@interface ZDNavViewController ()<ZDTabBarDelegate>


/**
 *  自定义TabBar
 */
@property (nonatomic, weak) ZDTabBar *customTabBar;

@property (nonatomic, strong) ZDNewsViewController *home;
@property (nonatomic, strong) ZDTryViewController *message;
@property (nonatomic, strong) ZDBankViewController *discover;
@property (nonatomic, strong) ZDMyBabyViewController *baby;
@property (nonatomic, strong) ZDRecordViewController *record;

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
    [self popToRootViewControllerAnimated:NO];
}
- (ZDTabBar *)customTabBar
{
//    if (_customTabBar == nil) {
        // 1.创建自定义TabBar
        ZDTabBar *customTabBar = [[ZDTabBar alloc] init];
        customTabBar.frame = self.tabBarController.tabBar.bounds;
        customTabBar.delegate = self;
        [self.tabBarController.tabBar addSubview:customTabBar];
        self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
        self.customTabBar = customTabBar;
//    }
    return _customTabBar;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    // 1.1创建自定义控制器
    ZDNewsViewController *home = [[ZDNewsViewController alloc] init];
    [self setupChileViewController:home title:@"宝贝咨询" imageName:@"tab001_1" selectedImageName:@"tab001"];
    self.home = home;
    
    
    // 2.消息
    ZDTryViewController *message = [[ZDTryViewController alloc] init];
    [self setupChileViewController:message title:@"新食材尝试" imageName:@"tab002_2" selectedImageName:@"tab002"];
    self.message = message;
    
    ZDRecordViewController *record = [[ZDRecordViewController alloc] init];
    [self setupChileViewController:record title:@"尝试记录" imageName:@"tab002_2" selectedImageName:@"tab002"];
    self.record = record;
    
    // 3.广场
    ZDBankViewController *discover = [[ZDBankViewController alloc] init];
    [self setupChileViewController:discover title:@"宝贝食材银行" imageName:@"tab003_3" selectedImageName:@"tab003"];
    self.discover = discover;
    
    // 4.我
    ZDMyBabyViewController *baby = [[ZDMyBabyViewController alloc] init];
    [self setupChileViewController:baby title:@"我的宝贝" imageName:@"tab004_4" selectedImageName:@"tab004"];
    self.baby = baby;
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    [self.customTabBar bringSubviewToFront:self.view];
}

- (void)viewWillDisappear:(BOOL)animated{
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}



/**
 *  初始化子控制器
 *
 *  @param child             需要初始化的子控制器
 *  @param title             需要设置的标题
 *  @param imageName         需要设置的默认状态的图片
 *  @param selectedImageName 需要设置的选中状态的图片
 */
- (void)setupChileViewController:(UIViewController *)child title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    child.title = title;
    child.tabBarItem.image = [UIImage imageWithNamed:imageName];
    // 如果是iOS7 就告诉系统不要渲染图片
    UIImage *selectedImage = [UIImage imageWithNamed:selectedImageName];
    if (iOS7) { //只有iOS7才需要设置原样显示
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    child.tabBarItem.selectedImage = selectedImage;
    ZDNavViewController *nav = [[ZDNavViewController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    // 2.根据对应的子控制器创建子控制器对应的按钮
    [self.customTabBar addTabBarButton:child.tabBarItem];
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{

    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    [super popToRootViewControllerAnimated:YES];
    return nil;
}

@end
