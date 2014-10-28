//
//  ZDSiKuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSiKuViewController.h"
#import "ZDTabBarController.h"
#import "CZProductCell.h"
#import "CZProduct.h"

static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";
@interface ZDSiKuViewController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ZDSiKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chushihua];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    layout.headerReferenceSize = CGSizeMake(self.collection.bounds.size.width, 30);
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.collectionViewLayout = layout;
    // 为CollectionView注册可重用单元格
    UINib *nib = [UINib nibWithNibName:@"CZProductCell" bundle:nil];
    [self.collection registerNib:nib forCellWithReuseIdentifier:ProductCellID];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
}

- (NSArray *)dataList
{
    if (!_dataList) _dataList = [CZProduct products];
    return _dataList;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
} 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // forIndexPath －》强行要求程序员必须注册表格的可重用单元格
    CZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellID forIndexPath:indexPath];
    
    // 以下判断不会工作
    //    if (cell == nil) {
    //        //
    //    }
    
    // 用模型设置cell
    cell.product = self.dataList[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[headerView viewWithTag:1];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 5, 5)];
        label.tag = 1;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [UIColor redColor];
        [headerView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"  蔬菜类%d", indexPath.section+1];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CZProduct *product = self.dataList[indexPath.item];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CZProductCell *celll = (CZProductCell *)cell;
    celll.selectBtn.selected = !celll.selectBtn.selected;
    
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
