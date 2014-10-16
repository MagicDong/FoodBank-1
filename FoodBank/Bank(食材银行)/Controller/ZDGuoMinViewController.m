//
//  ZDGuoMinViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDGuoMinViewController.h"
#import "ZDTabBarController.h"

@interface ZDGuoMinViewController ()
@property (weak, nonatomic) IBOutlet UIButton *anquan;                  // 安全库按钮
@property (weak, nonatomic) IBOutlet UIButton *guomin;                  // 过敏库按钮
@property (weak, nonatomic) IBOutlet UIButton *jujue;                   // 拒绝库按钮
@property (weak, nonatomic) IBOutlet UIButton *weichangshi;             // 未尝试库按钮
@property (weak, nonatomic) IBOutlet UILabel *label1;                   // 
@property (weak, nonatomic) IBOutlet UICollectionView *collection;      //
@property (weak, nonatomic) IBOutlet UILabel *label2;                   // 
@property (nonatomic, strong) NSArray *products;                        // 
@property (nonatomic, weak) UIButton  *selectedBtn;                     // 当前选中的四库
@end

@implementation ZDGuoMinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    [self chushihua];
}
- (void)chushihua{
    self.title = @"过敏食材库";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    self.anquan.layer.cornerRadius = 3;
    self.anquan.layer.masksToBounds = YES;
    
    
    self.guomin.layer.cornerRadius = 3;
    self.guomin.layer.masksToBounds = YES;
    self.guomin.selected = YES;
    self.selectedBtn = self.guomin;
    
    self.jujue.layer.cornerRadius = 3;
    self.jujue.layer.masksToBounds = YES;
    
    self.weichangshi.layer.cornerRadius = 3;
    self.weichangshi.layer.masksToBounds = YES;
}

- (IBAction)anquan:(UIButton *)sender {
    [self btnClick:sender];
}

- (IBAction)guomin:(UIButton *)sender {
    [self btnClick:sender];
}

- (IBAction)jujue:(UIButton *)sender {
    [self btnClick:sender];
}
- (IBAction)weichangshi:(UIButton *)sender {
    [self btnClick:sender];
}

- (void)btnClick:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (IBAction)queding:(UIButton *)sender {
    // 跳转到TabBarController
    ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    app.statusBarHidden = NO;
    window.rootViewController = tabBarVc;
}
@end
