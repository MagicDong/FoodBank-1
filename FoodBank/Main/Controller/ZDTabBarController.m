//
//  TabBarController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTabBarController.h"
#import "ZDTabBar.h"
#import "ZDTabBarButton.h"
#import "ZDRegisterViewController.h"
#import "ZDNavViewController.h"

@interface ZDTabBarController () <ZDTabBarDelegate>
/**
 *  自定义TabBar
 */
@property (nonatomic, weak) ZDTabBar *customTabBar;

@property (nonatomic, strong) ZDRegisterViewController *home;
@property (nonatomic, strong) ZDRegisterViewController *message;
@property (nonatomic, strong) ZDRegisterViewController *discover;
@property (nonatomic, strong) ZDRegisterViewController *profile;
@end

@implementation ZDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        // 1.1创建自定义控制器
        ZDRegisterViewController *home = [[ZDRegisterViewController alloc] init];
        [self setupChileViewController:home title:@"首页" imageName:@"tab001_1" selectedImageName:@"tab001"];
        self.home = home;
        
        
        // 2.消息
        ZDRegisterViewController *message = [[ZDRegisterViewController alloc] init];
        [self setupChileViewController:message title:@"消息" imageName:@"tab002_2" selectedImageName:@"tab002"];
        self.message = message;
        
        // 3.广场
        ZDRegisterViewController *discover = [[ZDRegisterViewController alloc] init];
        [self setupChileViewController:discover title:@"广场" imageName:@"tab003_3" selectedImageName:@"tab003"];
        self.discover = discover;
        
        // 4.我
        ZDRegisterViewController *profile = [[ZDRegisterViewController alloc] init];
        [self setupChileViewController:profile title:@"我" imageName:@"tab004_4" selectedImageName:@"tab004"];
        self.profile = profile;
    }
    return self;
}

- (ZDTabBar *)customTabBar
{
    if (_customTabBar == nil) {
        // 1.创建自定义TabBar
        ZDTabBar *customTabBar = [[ZDTabBar alloc] init];
        customTabBar.frame = self.tabBar.bounds;
        customTabBar.delegate = self;
        [self.tabBar addSubview:customTabBar];
        self.customTabBar = customTabBar;
    }
    return _customTabBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
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
    //    child.view.backgroundColor =  IWRandomColor;
    // 1.2设置控制器对应的tabBar的属性
    //    child.tabBarItem.title = title;
    //    child.navigationItem.title = title;
    child.title = title;
    
    child.tabBarItem.image = [UIImage imageWithNamed:imageName];
    // 如果是iOS7 就告诉系统不要渲染图片
    UIImage *selectedImage = [UIImage imageWithNamed:selectedImageName];
    
    if (iOS7) { //只有iOS7才需要设置原样显示
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    child.tabBarItem.selectedImage = selectedImage;
    
    // 包装一个导航控制器
    //    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:child];
    
    ZDNavViewController *nav = [[ZDNavViewController alloc] init];
    [nav addChildViewController:child];
    
    // 1.3添加自定义控制器到TabBarController
    [self addChildViewController:nav];
    
    // 2.根据对应的子控制器创建子控制器对应的按钮
    [self.customTabBar addTabBarButton:child.tabBarItem];
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZDTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    if (to == from) {
//        两次点击相同
        
    }
}



@end
