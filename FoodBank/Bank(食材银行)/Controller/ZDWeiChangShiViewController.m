//
//  ZDWeiChangShiViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-16.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDWeiChangShiViewController.h"
#import "ZDProductCell.h"
#import "CZProduct.h"

static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";

@interface ZDWeiChangShiViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation ZDWeiChangShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未尝试食材库";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    layout.headerReferenceSize = CGSizeMake(self.collection.bounds.size.width, 30);
    UINib *nib = [UINib nibWithNibName:@"ZDProductCell" bundle:nil];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.collectionViewLayout = layout;
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
    ZDProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellID forIndexPath:indexPath];
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

- (IBAction)queding:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
