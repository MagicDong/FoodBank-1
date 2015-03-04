//
//  ZDSiKuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDJuJueController.h"
#import "ZDTabBarController.h"
#import "CZProductCell.h"
#import "CZProduct.h"
#import "ZDFoodCategory.h"
#import "MBProgressHUD+ZD.h"
#import "ZDCategoryCell.h"
#import "ZDNetwork.h"
#import "AppDelegate.h"
#import "YTKKeyValueStore.h"

static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";
static NSString *categoryCellID = @"categoryCell";

@interface ZDJuJueController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic, strong) NSArray *products;
/**
 *  当前选中食材库
 */
@property (nonatomic, weak) UIButton  *selectedBtn;
@property (nonatomic, strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *quanxuan;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSIndexPath *path;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, strong) NSMutableDictionary *categoryCount;
@property (nonatomic, strong) YTKKeyValueStore *store;
@end

@implementation ZDJuJueController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chushihua];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(73, 85);
    layout.minimumLineSpacing = 3.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(self.collection.bounds.size.width, 30);
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.collectionViewLayout = layout;
    // 为CollectionView注册可重用单元格
    UINib *nib = [UINib nibWithNibName:@"CZProductCell" bundle:nil];
    [self.collection registerNib:nib forCellWithReuseIdentifier:ProductCellID];
//    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
    self.integer = 0;
    self.quanxuan.layer.cornerRadius = 3;
    self.quanxuan.layer.masksToBounds = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.firstLineHeadIndent = 25.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    
    self.textView.attributedText = [[NSAttributedString alloc]initWithString:@"请您将宝宝已尝试过（尝试3-7天）且未发生过敏、拒绝等现象）的食材勾选出来。" attributes:attributes];
    
    UINib *categoryNib = [UINib nibWithNibName:@"ZDCategoryCell" bundle:nil];
    [self.tableView registerNib:categoryNib forCellReuseIdentifier:categoryCellID];
    self.tableView.bounces = YES;
    
    // 3.添加更多按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingd)];
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
    self.store = store;
    NSString *tableName = @"user_table";
    [store createTableWithName:tableName];
    for (int i = 0; i<16; i++) {
        NSNumber *number = @0;
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [store putNumber:number withId:str intoTable:tableName];
    }
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    self.tableView.setexclusiveTouch = YES;
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tableView setNeedsDisplay];
    self.collection.allowsMultipleSelection = YES;
    
    self.integer = selectedIndexPath.row;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.categoryCount = [NSMutableDictionary dictionary];
    for (int i = 0; i<self.dataList.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [self.categoryCount setObject:@0 forKey:str];
    }
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"share";
    ZDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
    ZDFoodCategory *category = self.dataList[indexPath.row];
    if ([category.foodGenre isEqualToString:@"大豆及制品类"]) {
        cell.title = @"大豆及制品";
    }else{
        cell.title = category.foodGenre;
    }
    if (indexPath.row == self.integer) {
        cell.zhuangtai = 1;
        cell.selected = YES;
    }else{
        cell.zhuangtai = 0;
        cell.selected = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    cell.contentView.backgroundColor =[UIColor colorWithRed:240 green:241 blue:244 alpha:1];
//    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    tableView.backgroundColor = [UIColor colorWithRed:240 green:241 blue:244 alpha:1];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.backgroundColor = [UIColor redColor];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.integer == 0) {
        ZDCategoryCell *cell =  (ZDCategoryCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.zhuangtai = 0;
    }
    ZDCategoryCell *cell =  (ZDCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.zhuangtai = 1;
    self.integer = indexPath.row;
    [self.collection reloadData];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCategoryCell *cell = (ZDCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.zhuangtai = 0;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (NSArray *)dataList{
    if (!_dataList) {
        [ZDNetwork getSiKuCategory:@"1" Callback:^(RspState *rsp, NSArray *array) {
            _dataList = array;
            if(array.count){
                [self.collection reloadData];
                [self.tableView reloadData];
            }
        }];
    }
    return _dataList;
}

#pragma mark - 数据源方法
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    NSInteger count = self.dataList.count;
//    return count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ((self.integer)) {
        ZDFoodCategory *foodCategory = self.dataList[self.integer];
        return foodCategory.foodGenreList.count;
    }else{
        ZDFoodCategory *foodCategory = self.dataList[0];
        return foodCategory.foodGenreList.count;
    }
    
} 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // forIndexPath －》强行要求程序员必须注册表格的可重用单元格
    CZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellID forIndexPath:indexPath];
    
    ZDFoodCategory *foodCategory = self.dataList[self.integer];
    NSDictionary *dict = foodCategory.foodGenreList[indexPath.row];
    cell.foodDict = dict;
    cell.selectArray = self.selectArray;
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
//                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
//    UILabel *label = (UILabel *)[headerView viewWithTag:1];
//    if (!label) {
//        label = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 5, 5)];
//        label.tag = 1;
//        label.font = [UIFont boldSystemFontOfSize:14];
//        label.textColor = [UIColor redColor];
//        [headerView addSubview:label];
//    }
//    ZDFoodCategory *foodCategory = self.dataList[self.integer];
//    label.text = [NSString stringWithFormat:@" %@",foodCategory.foodGenre];
//    
//    return headerView;
//}

int countcount;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CZProduct *product = self.dataList[indexPath.item];
    NSInteger oldCount = self.selectArray.count;
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
    
    
    NSInteger newCount = self.selectArray.count;
    if (oldCount < newCount) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)self.integer];
        NSNumber *number = [self.store getNumberById:str fromTable:@"user_table"];
        NSInteger iiii = [number integerValue];
        iiii++;
        NSNumber *num = [NSNumber numberWithInteger:iiii];
        [self.store putNumber:num withId:str intoTable:@"user_table"];
//        NSLog(@"%@",num);
    }else{
        NSString *str = [NSString stringWithFormat:@"%ld",(long)self.integer];
        NSNumber *number = [self.store getNumberById:str fromTable:@"user_table"];
        NSInteger iiii = [number integerValue];
        iiii--;
        NSNumber *num = [NSNumber numberWithInteger:iiii];
        [self.store putNumber:num withId:str intoTable:@"user_table"];
//        NSLog(@"%@",num);
    }

    
    ZDCategoryCell *category =  (ZDCategoryCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.integer inSection:0]];
    NSString *str = [NSString stringWithFormat:@"%ld",(long)self.integer];
    NSNumber *number = [self.store getNumberById:str fromTable:@"user_table"];
    NSInteger iiii = [number integerValue];
    category.bage = iiii;
    
//    category.bage = 
    
//    cell
    
//    cell
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

- (void)chushihua{
    self.title = @"拒绝食材库";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}

- (void)btnClick:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

//- (IBAction)queding:(UIButton *)sender {
//
//}

- (void)dealloc{
//    ZDLog(@"四库界面销毁");
}




@end
