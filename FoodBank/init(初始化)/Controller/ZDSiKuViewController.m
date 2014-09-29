//
//  ZDSiKuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSiKuViewController.h"
#import "ZDTabBarController.h"

@interface ZDSiKuViewController ()
//<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *anquan;
@property (weak, nonatomic) IBOutlet UIButton *guomin;
@property (weak, nonatomic) IBOutlet UIButton *jujue;
@property (weak, nonatomic) IBOutlet UIButton *weichangshi;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic, strong) NSArray *products;
/**
 *  当前选中食材库
 */
@property (nonatomic, weak) UIButton  *selectedBtn;
@end

@implementation ZDSiKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chushihua];
}
- (NSArray *)products
{
    if (!_products){
        NSArray *arr1 = @[@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿"];
        NSArray *arr2 = @[@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿",@"胡萝卜",@"西红柿"];
        _products = @[arr1,arr2];
    }
    return _products;
}
#pragma mark - 数据源方法
// 返回每个section（分组）中的item（条目，小格子）的数量
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return [self.products[section] count];
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.products.count;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusable = [[UICollectionReusableView alloc]init];
//    return reusable;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    static NSString *ID = @"Cell";
//    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
//    return cell;
//}
- (void)chushihua{
    self.title = @"勾选四库";
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
