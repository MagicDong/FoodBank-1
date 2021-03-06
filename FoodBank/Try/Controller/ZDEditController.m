//
//  ZDSiKuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDEditController.h"
#import "ZDTabBarController.h"
#import "CZProductCell.h"
#import "CZProduct.h"
#import "ZDFoodCategory.h"
#import "MBProgressHUD+ZD.h"
#import "ZDCategoryCell.h"
#import "ZDNetwork.h"

static NSString *ProductCellID = @"ProductCell";
static NSString *reusableViewID = @"SectionHeader";
static NSString *categoryCellID = @"categoryCell";

@interface ZDEditController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

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
@end

@implementation ZDEditController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(queding)];
    
    
    self.categoryCount = [NSMutableDictionary dictionary];
    //    [self.categoryCount setValue:@1 forKey:@"1"];
    //    [self what_are_you_doing];
}

//- (void)what_are_you_doing {
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeRight;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//}

- (void)queding{
    // 跳转到TabBarController
    for (UIViewController *controller in self.childViewControllers) {
        // 将子视图控制器的视图从父视图中删除
        [controller.view removeFromSuperview];
        // 将视图控制器从父视图控制器中删除
        [controller removeFromParentViewController];
    }
    [self.view removeFromSuperview];
    [MBProgressHUD showMessage:@"初始化中"];
    [MBProgressHUD hideHUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZDNetwork postBabySiKuInfoWithMids:self.selectArray CallBack:^(RspState *rsp) {
            if (rsp.rspCode == 0) {
                [MBProgressHUD hideHUD];
            }else{
                [MBProgressHUD hideHUD];
            }
        }];
        
        
        ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *window = app.keyWindow;
        app.statusBarHidden = NO;
        window.rootViewController = tabBarVc;
    });
    
}

- (IBAction)quanxuan:(UIButton *)sender {
//    [self.collection cellForItemAtIndexPath:];
    for (int row=0; row<[self.dataList[self.integer] foodGenreList].count; row++) {
//        NSLog(@"%d",row);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}

////只返回可见的cell
//- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
////只返回当前不可见的cell
//- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier

- (void)viewDidAppear:(BOOL)animated{
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        [ZDNetwork getSiKuInfoCallback:^(RspState *rsp, NSArray *array) {
            _dataList = array;
            [self.collection reloadData];
            [self.tableView reloadData];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZDFoodCategory *foodCategory = self.dataList[self.integer];
    NSDictionary *dict = foodCategory.foodGenreList[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedMid:)]) {
        [self.delegate didSelectedMid:dict];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
//    CZProduct *product = self.dataList[indexPath.item];
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    CZProductCell *product = (CZProductCell *)cell;
//    product.selectBtn.selected = !product.selectBtn.selected;
//    if (product.selectBtn.selected) {
//        if ([self.selectArray containsObject:product.mid]) {
//            [self.selectArray removeObject:product.mid];
//        }else{
//            [self.selectArray addObject:product.mid];
//        }
//    }else{
//        
//        NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:product.mid, nil];
//        /*
//         方法一：利用NSPredicate
//         注：NSPredicate所属Cocoa框架，在密码、用户名等正则判断中经常用到。
//         类似于SQL语句
//         NOT 不是
//         SELF 代表字符串本身
//         IN 范围运算符
//         那么NOT (SELF IN %@) 意思就是：不是这里所指定的字符串的值
//         */
//        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
//        //过滤数组
//        NSArray * reslutFilteredArray = [self.selectArray filteredArrayUsingPredicate:filterPredicate];
//        self.selectArray = [reslutFilteredArray mutableCopy];
//    }
    
    
//    NSLog(@",,,,,%@",self.selectArray);
//    NSLog(@"======%@",self.selectArray);
    
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}


- (void)chushihua{
    self.title = @"更换尝试新食材";
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

- (void)dealloc{
//    ZDLog(@"四库界面销毁");
}




@end
