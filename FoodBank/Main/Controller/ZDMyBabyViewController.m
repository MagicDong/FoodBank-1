//
//  ZDMyBabyViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDMyBabyViewController.h"
#import "MBProgressHUD+ZD.h"
#import "ZDMoreHeaderView.h"
#import "ZDAccountTool.h"
#import "ZDAboutViewController.h"
#import "ZDBabyInfoTableViewController.h"
#import "ZDMoreHeaderView.h"
#import "ZDAccountTool.h"
#import "ZDAccount.h"
#import "NSDate+ZD.h"
#import "UIView+ZD.h"
#import "UIImage+ZD.h"
#import "ZDKnowTableViewController.h"
#import "ZDNewfeatureViewController.h"
#import "ZDMoreView.h"
#import "ZDProductViewController.h"
#import "ZDRspViewController.h"

static NSString *heardID = @"headerView";
@interface ZDMyBabyViewController ()<UIAlertViewDelegate,ZDMoreHeaderViewDelegate,ZDMoreViewDelegate>
{
    ZDMoreHeaderView *_headerView;
}
@property (nonatomic,assign) BOOL settingEdge;

@property (nonatomic,strong) UIImageView *bgIcon;
/**
 *  蒙板
 */
@property (nonatomic, strong)UIButton *cover;
/**
 *  时间选择
 */
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@end

@implementation ZDMyBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的宝贝";
    [self setupItems];
    self.tableView.sectionFooterHeight = 10;
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    self.tableView.scrollEnabled= YES;
    self.tableView.backgroundColor = ZDColor(219, 219, 219);
    NSString *imageName =[NSString stringWithFormat:@"more_baobao_bg"];
    _bgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    _bgIcon.bounds = CGRectMake(0, 0, 320, 300);
    _bgIcon.layer.anchorPoint = CGPointMake(0.5, 0);
    _bgIcon.layer.position = CGPointMake(160, -95);
    [self.tableView insertSubview:_bgIcon atIndex:0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 3.添加更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)more{
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
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
- (void)moreViewDidWWW:(ZDMoreView *)moreView{
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 20) return;
    // 1.向上的阻力系数（值越大，阻力越大，向上的力越大）
    CGFloat upFactor = 0.6;
    // 2.到什么位置开始放大
    // value越大，越早放大
    CGFloat value = 50;
    CGFloat upMin = - (_bgIcon.frame.size.height / value) / (1 - upFactor);
    // 3.还没到特定位置，就网上挪动
    if (offsetY >= upMin) {
        _bgIcon.transform = CGAffineTransformMakeTranslation(0, offsetY * upFactor);
    } else {
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, offsetY - upMin * (1 - upFactor));
        CGFloat s = 1 + (upMin - offsetY) * 0.005;
        _bgIcon.transform = CGAffineTransformScale(transform, s, s);
    }
}


// 通用数据
- (void)setupItems
{
    /** 0组 */
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupFooter];
    // 设置footerView
    _headerView = [ZDMoreHeaderView moreHeaderView];
    _headerView.headerDelegate = self;
    self.tableView.tableHeaderView = _headerView;
}

/** 点击头部 */
- (void)didClickHeaderView:(BOOL)isAccount
{
    ZDBabyInfoTableViewController *babyInfo = [[ZDBabyInfoTableViewController alloc]init];
    [self.navigationController pushViewController:babyInfo animated:YES];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 2.设置标题
    [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    // 3.设置背景图片
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backAccount) forControlEvents:UIControlEventTouchUpInside];
    // 4.设置frame
    btn.height = 45;
    self.tableView.tableFooterView = btn;
}

- (void)backAccount
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出此账号?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [ZDAccountTool removeAccount];
        for (UIViewController *controller in self.childViewControllers) {
            // 将子视图控制器的视图从父视图中删除
            [controller.view removeFromSuperview];
            // 将视图控制器从父视图控制器中删除
            [controller removeFromParentViewController];
        }
        UIApplication *app = [UIApplication sharedApplication];
        [app.delegate application:app didFinishLaunchingWithOptions:nil];
    }
}

- (void)dealloc
{
//    NSLog(@"baby dealloc");
}

- (void)setupGroup1{
    ZDCommonArrowItem *rsp = [ZDCommonArrowItem itemWithTitle:@"接口测试"];
    rsp.destVC =  [ZDRspViewController class];
    
    ZDCommonArrowItem *updata = [ZDCommonArrowItem itemWithTitle:@"宝贝知识库"];
    updata.destVC =  [ZDKnowTableViewController class];
    
    ZDCommonArrowItem *guide = [ZDCommonArrowItem itemWithTitle:@"新手指南"];
//    __weak typeof(self) weakSelf = self;
    guide.opertion = ^{
        for (UIViewController *controller in self.childViewControllers) {
            // 将子视图控制器的视图从父视图中删除
            [controller.view removeFromSuperview];
            // 将视图控制器从父视图控制器中删除
            [controller removeFromParentViewController];
        }
        NSDictionary *dict = @{@"news":@"news"};
        UIApplication *app = [UIApplication sharedApplication];
        [app.delegate application:app didFinishLaunchingWithOptions:dict];
    };
    ZDCommonArrowItem *tuijian = [ZDCommonArrowItem itemWithTitle:@"产品推荐"];
    tuijian.destVC = [ZDProductViewController class];
    
    ZDCommonGroup *group = [self addGroup];
    group.items = @[rsp,updata,guide,tuijian];
    
}

- (void)setupGroup2{
    
    ZDCommonArrowItem *updata = [ZDCommonArrowItem itemWithTitle:@"检测更新"];
    NSString *key =  (__bridge NSString *)kCFBundleVersionKey;
    NSString *versionCode = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    updata.subtitle = [NSString stringWithFormat:@"当前版本:%@",versionCode];
    updata.opertion = ^{
        // 1.获得用户当前软件的版本
        
        // 2.把当前版本号发给服务器
        if (/* DISABLES CODE */ (NO)) { // 有新版本
            // 2.1.弹框显示有新版本，展示版本新特性
            NSString *appid = @"908308962";
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
            NSURL *url = [NSURL URLWithString:str];
            [[UIApplication sharedApplication] openURL:url];
            // 2.2.点击“马上更新”，跳到appstore（跟评分功能一致）
        } else {
            [MBProgressHUD showSuccess:@"当前为最新版本"];
        }
    };
    
    ZDCommonArrowItem *clearCache = [ZDCommonArrowItem itemWithTitle:@"清除图片缓存"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachesPath = [path stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    double fileSize = [self sizeAtPath:cachesPath]/(1024.0);
    clearCache.subtitle = [NSString stringWithFormat:@"%.fMB",fileSize];
    __weak typeof (self) weakSelf = self;
    __weak typeof (clearCache) weakClearCache = clearCache;
    
    
    clearCache.opertion = ^(){
        // 1.提示用户
        [MBProgressHUD showMessage:@"正在清除缓存ing...."];
        // 2.删除缓存文件夹
        // 2.1获取文件管理者对象
        NSFileManager *manager =  [NSFileManager defaultManager];
        BOOL success = [manager removeItemAtPath:cachesPath error:nil];
        // 3.隐藏提示框
        [MBProgressHUD hideHUD];
        if (success) {
            [MBProgressHUD showSuccess:@"删除成功"];
            weakClearCache.subtitle = nil;
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showError:@"没有缓存文件!"];
            weakClearCache.subtitle = nil;
            [weakSelf.tableView reloadData];
        }
    };
    ZDCommonGroup *group = [self addGroup];
    group.items = @[clearCache,updata];
}
- (void)setupGroup3{
    ZDCommonArrowItem *idea = [ZDCommonArrowItem itemWithTitle:@"意见反馈"];
    idea.opertion = ^(){
        NSString *appid = @"908308962";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    };
    ZDCommonArrowItem *about = [ZDCommonArrowItem itemWithTitle:@"关于我们"];
    about.destVC = [ZDAboutViewController class];
    ZDCommonGroup *group = [self addGroup];
    group.items = @[idea,about];
    
}

/** 计算路径文件的大小 */
- (int)sizeAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *dict = [manager attributesOfItemAtPath:path error:nil];
    return [dict[NSFileSize] intValue];
}

@end
