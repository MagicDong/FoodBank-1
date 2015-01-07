//
//  ZDSelectViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/24.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSelectViewController.h"
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
@interface ZDSelectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, weak) UIButton  *selectedBtn;
@property (nonatomic, strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *selectFoodArray;
@property (nonatomic, strong) NSIndexPath *path;
@property (nonatomic, assign) NSInteger integer;

@end

@implementation ZDSelectViewController

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
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
    self.integer = 0;
    self.queding.layer.cornerRadius = 8;
    self.queding.layer.masksToBounds = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.firstLineHeadIndent = 25.f;
    
    
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    self.textView.attributedText = [[NSAttributedString alloc]initWithString:@"请您将宝宝父母已过敏（发生过敏、拒绝等现象）的食材勾选出来。" attributes:attributes];
    
    UINib *categoryNib = [UINib nibWithNibName:@"ZDCategoryCell" bundle:nil];
    [self.tableView registerNib:categoryNib forCellReuseIdentifier:categoryCellID];
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *ID = @"share";
    ZDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
    ZDFoodCategory *category = self.dataList[indexPath.row];
    if (indexPath.row == self.integer) {
        cell.zhuangtai = 1;
        cell.selected = YES;
    }else{
        cell.zhuangtai = 0;
        cell.selected = NO;
    }
    if ([category.foodGenre isEqualToString:@"大豆及制品类"]) {
        cell.title = @"大豆及制品";
    }else{
        cell.title = category.foodGenre;
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
    return 44;
}

- (NSArray *)dataList{
    if (!_dataList) {
        [ZDNetwork getGuoMinCallback:^(RspState *rsp, NSArray *array) {
            if(rsp.rspCode == 0){
                _dataList = array;
                //            ZDLog(@"23232%d",array.count);
                [self.collection reloadData];
                [self.tableView reloadData];
            }else{
//                [MBProgressHUD showMessage:@"网络错误"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [MBProgressHUD hideHUD];
//                });
            }
        }];
    }
    return _dataList;
}
//[{"foodGenre":"谷类","foodGenreList":[{"mname":"大米","mtpid":17,"msame":"大米","mid":24},{"mname":"糯米","mtpid":17,"msame":"糯米"}}；
// {"foodGenre":"谷类","foodGenreList":[["1","面粉","面粉","谷类"],["8","婴幼儿面","面粉","谷类"]
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
    NSArray *dict = foodCategory.foodGenreList[indexPath.row];
    cell.guominArray = dict;
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
    ZDFoodCategory *foodCategory = self.dataList[self.integer];
    label.text = [NSString stringWithFormat:@" %@",foodCategory.foodGenre];
    
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CZProduct *product = self.dataList[indexPath.item];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CZProductCell *product = (CZProductCell *)cell;
    
    product.selectBtn.selected = !product.selectBtn.selected;
    if (product.selectBtn.selected) {
        if ([self.selectArray containsObject:product.guominArray[0]]) {
            [self.selectFoodArray removeObject:product.guominArray[1]];
            [self.selectArray removeObject:product.guominArray[0]];
        }else{
            [self.selectArray addObject:product.guominArray[0]];
            [self.selectFoodArray addObject:product.guominArray[1]];
        }
    }else{
        
        NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:product.guominArray[0], nil];
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
        //过滤数组
        NSArray * reslutFilteredArray = [self.selectArray filteredArrayUsingPredicate:filterPredicate];
        self.selectArray = [reslutFilteredArray mutableCopy];
        
        NSMutableArray *filteredArray1 = [[NSMutableArray alloc]initWithObjects:product.guominArray[1], nil];
        NSPredicate * filterPredicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray1];
        //过滤数组
        NSArray * reslutFilteredArray1 = [self.selectFoodArray filteredArrayUsingPredicate:filterPredicate1];
        self.selectFoodArray = [reslutFilteredArray1 mutableCopy];
        
        
    }
    
    //    NSLog(@",,,,,%@",self.selectArray);
    //    NSLog(@"======%@",self.selectArray);
}


- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}
- (NSMutableArray *)selectFoodArray{
    if (!_selectFoodArray) {
        _selectFoodArray = [[NSMutableArray alloc]init];
    }
    return _selectFoodArray;
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
    self.title = @"父母过敏食材选择";
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

- (IBAction)queding:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(selectFoodArray:)]) {
        [self.delegate selectFoodArray:self.selectFoodArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
//    // 跳转到TabBarController
//    for (UIViewController *controller in self.childViewControllers) {
//        // 将子视图控制器的视图从父视图中删除
//        [controller.view removeFromSuperview];
//        // 将视图控制器从父视图控制器中删除
//        [controller removeFromParentViewController];
//    }
//    [self.view removeFromSuperview];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [ZDNetwork postBabySiKuInfoWithMids:self.selectArray CallBack:^(RspState *rsp) {
//            if (rsp.rspCode == 0) {
//                [MBProgressHUD hideHUD];
//            }else{
//                [MBProgressHUD hideHUD];
//            }
//        }];
//        ZDTabBarController *tabBarVc = [[ZDTabBarController alloc] init];
//        UIApplication *app = [UIApplication sharedApplication];
//        UIWindow *window = app.keyWindow;
//        app.statusBarHidden = NO;
//        window.rootViewController = tabBarVc;
//    });
}

- (void)dealloc{
    //    ZDLog(@"四库界面销毁");
}



@end
