//
//  ZDEditViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDEditViewController.h"
#import "CZProductCell.h"
#import "CZProduct.h"
#import "ZDFoodCategory.h"
#import "ZDNetwork.h"
#import "MBProgressHUD+ZD.h"
#import "ZDNetwork.h"
static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";

@interface ZDEditViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
//@property (weak, nonatomic) IBOutlet UILabel *label1;
//@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, weak) UIButton  *selectedBtn;   //  当前选中按钮
@property (nonatomic, strong) NSArray *dataList;      //
//@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (nonatomic, strong) NSMutableArray *selectArray;
@end

@implementation ZDEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改尝试食材";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(75, 86);
    layout.minimumLineSpacing = 5.0f;
    layout.minimumInteritemSpacing = 5.0f;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(self.collection.bounds.size.width, 30);
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.collectionViewLayout = layout;
    // 为CollectionView注册可重用单元格
    UINib *nib = [UINib nibWithNibName:@"CZProductCell" bundle:nil];
    [self.collection registerNib:nib forCellWithReuseIdentifier:ProductCellID];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
    
}


- (NSArray *)dataList{
    if (!_dataList) {
        
        [ZDNetwork getSiKuInfoCallback:^(RspState *rsp, NSArray *array) {
            self.dataList = array;
            ZDLog(@"23232%d",array.count);
            [self.collection reloadData];
        }];
    }
    return _dataList;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger count = self.dataList.count;
    
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZDFoodCategory *foodCategory = self.dataList[section];
    //    ZDLog(@"22%d",foodCategory.foodGenreList.count);
    return foodCategory.foodGenreList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // forIndexPath －》强行要求程序员必须注册表格的可重用单元格
    CZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellID forIndexPath:indexPath];
    ZDFoodCategory *foodCategory = self.dataList[indexPath.section];
    NSDictionary *dict = foodCategory.foodGenreList[indexPath.row];
    cell.foodDict = dict;
    cell.selectArray = self.selectArray;
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
    ZDFoodCategory *foodCategory = self.dataList[indexPath.section];
    label.text = [NSString stringWithFormat:@" %@",foodCategory.foodGenre];
    return headerView;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataList[indexPath.section];
    NSDictionary *dcit = array[indexPath.row];
    //    CZProduct *product = self.dataList[indexPath.item];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CZProductCell *product = (CZProductCell *)cell;
    product.selectBtn.selected = !product.selectBtn.selected;
    if (product.selectBtn.selected) {
        if ([self.selectArray containsObject:product.mid]) {
            [self.selectArray removeObject:product.mid];
        }else{
            [self.selectArray addObject:product.mid];
        }
    }else{
        NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:product.mid, nil];
        /*
         方法一：利用NSPredicate
         注：NSPredicate所属Cocoa框架，在密码、用户名等正则判断中经常用到。
         类似于SQL语句
         NOT 不是
         SELF 代表字符串本身
         IN 范围运算符
         那么NOT (SELF IN %@) 意思就是：不是这里所指定的字符串的值
         */
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
        //过滤数组
        NSArray * reslutFilteredArray = [self.selectArray filteredArrayUsingPredicate:filterPredicate];
        self.selectArray = [reslutFilteredArray mutableCopy];
        
    }
    //    NSLog(@",,,,,%@",self.selectArray);
    //
    //
    //    NSLog(@"======%@",self.selectArray);
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
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

- (void)btnClick:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

@end
