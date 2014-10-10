//
//  ZDAnQuanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDAnQuanViewController.h"
#import "ZDTabBarController.h"

@interface ZDAnQuanViewController ()

@property (weak, nonatomic) IBOutlet UIButton *anquan;
@property (weak, nonatomic) IBOutlet UIButton *guomin;
@property (weak, nonatomic) IBOutlet UIButton *jujue;
@property (weak, nonatomic) IBOutlet UIButton *weichangshi;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, weak) UIButton  *selectedBtn;
@end

@implementation ZDAnQuanViewController

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
    self.title = @"安全食材库";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    self.anquan.layer.cornerRadius = 3;
    self.anquan.layer.masksToBounds = YES;
    self.anquan.selected = YES;
    self.selectedBtn = self.anquan;
    
    self.guomin.layer.cornerRadius = 3;
    self.guomin.layer.masksToBounds = YES;
    
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
