//
//  ZDAnQuanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDAnQuanViewController.h"
#import "ZDTabBarController.h"
#import "ZDProductCell.h"
#import "CZProduct.h"

static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";

@interface ZDAnQuanViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *dataList;

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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    layout.headerReferenceSize = CGSizeMake(self.collection.bounds.size.width, 30);
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.collectionViewLayout = layout;
    // 为CollectionView注册可重用单元格
    UINib *nib = [UINib nibWithNibName:@"ZDProductCell" bundle:nil];
    [self.collection registerNib:nib forCellWithReuseIdentifier:ProductCellID];
    
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
    
//    {"foodGenre":"谷类","foodGenreList":[["55","薏米","薏米"]]},
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
    ZDProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellID forIndexPath:indexPath];
    
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
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor redColor];
        [headerView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"  蔬菜类%d", indexPath.section+1];
    return headerView;
}

- (void)chushihua{
    self.title = @"未过敏食材库";
    
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
    [self.navigationController popViewControllerAnimated:YES];
}


@end
