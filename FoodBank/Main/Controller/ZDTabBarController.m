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
#import "ZDBankViewController.h"
#import "ZDTryViewController.h"
#import "ZDNewsViewController.h"
#import "ZDRecordViewController.h"

@interface ZDTabBarController () <ZDTabBarDelegate>
@property (nonatomic, strong) ZDTabBar *customTabBar;
@property (nonatomic, strong) ZDNewsViewController *home;
@property (nonatomic, strong) ZDTryViewController *message;
@property (nonatomic, strong) ZDBankViewController *discover;
@property (nonatomic, strong) ZDMyBabyViewController *baby;
@property (nonatomic, strong) ZDRecordViewController *record;
@end

@implementation ZDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        // 1.宝贝咨询
        ZDNewsViewController *home = [[ZDNewsViewController alloc] init];
        [self setupChileViewController:home title:@"宝贝咨询" imageName:@"tu-baobaozixun" selectedImageName:@"tu-baobaozixun-lv"];
        self.home = home;
        
        // 2.新食材尝试
        ZDTryViewController *message = [[ZDTryViewController alloc] init];
        [self setupChileViewController:message title:@"新食材尝试" imageName:@"tu-xinshicaichangshi" selectedImageName:@"tu-xinshicaichangshi-lv"];
        self.message = message;
        
        // 3.尝试记录
        ZDRecordViewController *record = [[ZDRecordViewController alloc] init];
        [self setupChileViewController:record title:@"尝试记录" imageName:@"tu-changshijilu" selectedImageName:@"tu-changshijilu-lv"];
        self.record = record;
        
        // 4.宝贝食材银行
        ZDBankViewController *discover = [[ZDBankViewController alloc] init];
        [self setupChileViewController:discover title:@"食材银行" imageName:@"tu-shicaiyinhang" selectedImageName:@"tu-shicaiyinhang-lv"];
        self.discover = discover;
        
        // 4.我的宝贝
        ZDMyBabyViewController *baby = [[ZDMyBabyViewController alloc] init];
        [self setupChileViewController:baby title:@"我的宝贝" imageName:@"tu-wodebaobei" selectedImageName:@"tu-wodebaobei-lv"];
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
        
        self.tabBar.backgroundColor = [UIColor clearColor];
        self.customTabBar = customTabBar;
    }
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
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    [self.customTabBar bringSubviewToFront:self.view];
}

- (void)viewWillDisappear:(BOOL)animated{
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
- (void)didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    if (to == from) {
//        两次点击相同
        
    }
    
}



@end
