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
#import "ZDMyBabyViewController.h"
#import "ZDHelpViewController.h"
#import "ZDPlanViewController.h"
#import "ZDSquareViewController.h"

@interface ZDTabBarController () <ZDTabBarDelegate>
/**
 *  自定义TabBar
 */
@property (nonatomic, weak) ZDTabBar *customTabBar;

@property (nonatomic, strong) ZDSquareViewController *home;
@property (nonatomic, strong) ZDPlanViewController *message;
@property (nonatomic, strong) ZDHelpViewController *discover;
@property (nonatomic, strong) ZDMyBabyViewController *baby;
@end

@implementation ZDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        // 1.1创建自定义控制器
        ZDSquareViewController *home = [[ZDSquareViewController alloc] init];
        [self setupChileViewController:home title:@"广场" imageName:@"tab001_1" selectedImageName:@"tab001"];
        self.home = home;
        
        // 2.消息
        ZDPlanViewController *message = [[ZDPlanViewController alloc] init];
        [self setupChileViewController:message title:@"全计划" imageName:@"tab002_2" selectedImageName:@"tab002"];
        self.message = message;
        
        // 3.广场
        ZDHelpViewController *discover = [[ZDHelpViewController alloc] init];
        [self setupChileViewController:discover title:@"助手" imageName:@"tab003_3" selectedImageName:@"tab003"];
        self.discover = discover;
        
        // 4.我
        ZDMyBabyViewController *baby = [[ZDMyBabyViewController alloc] init];
        [self setupChileViewController:baby title:@"我的宝贝" imageName:@"tab004_4" selectedImageName:@"tab004"];
        self.baby = baby;
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
