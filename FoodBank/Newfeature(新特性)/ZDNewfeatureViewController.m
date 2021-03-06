//
//  RegisterViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNewfeatureViewController.h"
#import "ZDTabBarController.h"
#import "ZDRegisterViewController.h"
#import "ZDNavViewController.h"
#import "ZDTabBarController.h"
#import "ZDInitViewController.h"
#import "ZDBaby.h"
#import "ZDBabyTool.h"
#import "ZDNetwork.h"
#import "MBProgressHUD+ZD.h"

// 当前新特性页面的个数
#define ZDNewfeatureImageCount 3
/** 是否为4英寸屏 */
#define Inch4 ([UIScreen mainScreen].bounds.size.height >= 568.0)
/** 是否为4.7英寸屏 */
#define Inch47 ([UIScreen mainScreen].bounds.size.height >= 667.0)
/** 是否为5.5英寸屏 */
#define Inch55 ([UIScreen mainScreen].bounds.size.height >= 736.0)
@interface ZDNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak)  UIPageControl *pageControl;
@end

@implementation ZDNewfeatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.添加scrollerView
    [self setupScrollerView];
    // 2.添加PageControl
//    [self setupPageControl];
}
/**
 *  添加PageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.centerX = self.view.width * 0.5;
    pageControl.y = self.view.height - 30;
    pageControl.numberOfPages = ZDNewfeatureImageCount;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self.view addSubview:pageControl];
    self.pageControl  = pageControl;
}

/**
 *  添加scrollerView
 */
- (void)setupScrollerView
{
    
    UIScrollView *scrollerView = [[UIScrollView alloc] init];
    scrollerView.frame = self.view.bounds;
    scrollerView.delegate = self;
    [self.view addSubview:scrollerView];
    // 2.添加图片
    CGFloat width = scrollerView.width;
    CGFloat height = scrollerView.height;
    for (int i = 0; i < ZDNewfeatureImageCount; i++) {
        // 1.拼接图片名称
        NSString *imageName = [NSString stringWithFormat:@"boot_new_%d_480", i+ 1];
        if (Inch4) {
            /*
             默认情况下系统只支持自动加载启动图片的-568h图片
             如果-568h不是启动图片, 系统不会自动加载
             需要手动设置图片为4inch的图片, 已经手动拼接图片的名称
             */
            imageName = [NSString stringWithFormat:@"boot_new_%d_568", i+ 1];
        }else if(Inch47){
            imageName = [NSString stringWithFormat:@"boot_new_%d_667", i+ 1];
        }else if(Inch55){
            imageName = [NSString stringWithFormat:@"boot_new_%d_736", i+ 1];
        }
        UIImage *image = [UIImage imageNamed:imageName];
        // 2.创建UIImageView
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        // 3.设置frame
        iv.width = width;
        iv.height = height;
        iv.y = 0;
        iv.x = i * width;
        
        // 4.添加UIImageView到scrollerView
        [scrollerView addSubview:iv];
        
        // 5.拿到最后一个UIImageView添加按钮
        if (i == (ZDNewfeatureImageCount - 1)) {
            // 1.添加开始按钮
            [self setupStartButton:iv];
            // 2.添加分享按钮
//            [self setupShareButton:iv];
        }
    }
    
    // 3.设置scrollerView的相关属性
    scrollerView.contentSize = CGSizeMake(ZDNewfeatureImageCount * width, height);
    scrollerView.pagingEnabled = YES;
    scrollerView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    scrollerView.bounces = NO;
}

- (void)setupShareButton:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    // 2.设置文字和颜色
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 3.设置图标
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 4.监听按钮点击事件
    [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 5.设置frame
    shareButton.width = 200;
    shareButton.height = 35;
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
}

- (void)shareButtonClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

/**
 *  添加开始微博按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 0.让父控件可以和用户交互
    imageView.userInteractionEnabled = YES;
    // 1.创建按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    // 2.设置背景图片
//    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//    // 3.设置文字
//    [startButton setTitle:@"随便逛逛" forState:UIControlStateNormal];
    // 4.设置frame
    startButton.size = CGSizeMake(300 , 400);
    startButton.centerX = self.view.width * 0.3;
    startButton.centerY = self.view.height * 0.7;
    // 5.监听按钮点击事件
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

/*
 push: 必须有导航控制器 : 原有的控制器不会被销毁
 modal: 从下面钻出来: 原有的控制器不会被销毁
 切换window的rootviewController
 */
- (void)start
{
    // 判断当前是否已经有登陆过的账号存在
    ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
    
    if (baby.userName == nil) {
        ZDRegisterViewController *tabBarVc = [[ZDRegisterViewController alloc] init];
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *window = app.keyWindow;
        app.statusBarHidden = NO;
        window.rootViewController = tabBarVc;
        [window makeKeyAndVisible];
    }else{
        [ZDNetwork LoginWithPhone:baby.userName Password:baby.password Callback:^(RspState *rsp, NSString *jsessionid) {
            if (rsp.rspCode == 0) {
                ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
                ZDBaby *bb = [[ZDBaby alloc]init];
                bb.userName = baby.userName;
                bb.password = baby.password;
                bb.jsessionid = jsessionid;
                [babyTool saveAccount:bb];
            }else{
                [MBProgressHUD showError:@"网络错误"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
                
            }
        }];
        
        ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *window = app.keyWindow;
        app.statusBarHidden = NO;
        window.rootViewController = tabBarVc;
        [window makeKeyAndVisible];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取已经滚动的比例
    double ratio = scrollView.contentOffset.x / self.view.width;
    int page = (int)(ratio + 0.5);
    // 修改pageControl的页码
    self.pageControl.currentPage = page;
}

- (void)dealloc
{
//    ZDLog(@"dealloc");
}
@end
