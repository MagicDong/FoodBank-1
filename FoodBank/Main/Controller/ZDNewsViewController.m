//
//  ZDSquareViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNewsViewController.h"
#import "AFNetworking.h"
#import "CZBaseCell.h"
#import "CZTitleCell.h"
#import "CZNormalCell.h"
#import "ZDDetailViewController.h"
#import "ZDHttpTool.h"
#import "MBProgressHUD+ZD.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "CZPhotosCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "UIImage+ZD.h"
#import "ZDMoreView.h"
#import "ZDSpecialViewController.h"

static NSString *TitleCellID = @"TitleCell";
static NSString *NormalCellID = @"NormalCell";
static NSString *PhotosID = @"photosCell";

@interface ZDNewsViewController ()<CZTitleCellDelegate,UIGestureRecognizerDelegate,ZDMoreViewDelegate>
/** 数据列表 */
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic,assign) BOOL isMore;

@property (nonatomic,strong) CZTitleCell *titleCell;

@property (nonatomic,assign) BOOL isScience;
@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,assign) BOOL huancun;
@property (nonatomic, assign) UITouch *touch;
/**
 *  蒙板
 */
@property (nonatomic, strong)UIButton *cover;
/**
 *  时间选择
 */
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@property (nonatomic, weak) ZDSpecialViewController *specialVIew;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ZDNewsViewController

- (void)setDataList:(NSMutableArray *)dataList
{
    _dataList = dataList;
    
    [self.tableView reloadData];
}
- (void)dealloc{
//    [self.moreView removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.moreView removeFromSuperview];
    [self.cover removeFromSuperview];
}
- (void)viewDidAppear:(BOOL)animated{
    // 1.添加按钮蒙板
//    UIImageView *cover = [[UIImageView alloc] initWithFrame:self.view.window.bounds];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.image = [UIImage imageNamed:@"loginIcon.png"];
//    self.imageView = cover;
//    [self.view.window addSubview:cover];
//    [UIView animateWithDuration:2.0f animations:^{
//        [self.imageView setAlpha:0];
//        self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImageNamed:@"viewBG"]];
    self.title = @"宝贝资讯";
    [self setupRefresh];
    [self regCellNibs];
    self.huancun = YES;
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    // 3.添加更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
//    UIImageView *imaegView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginIcon.png"]];
//    imaegView.frame = self.view.window.frame;
//    [self.view.window addSubview:imaegView];
//    
//    [UIView animateWithDuration:1.5f animations:^{
//        imaegView.alpha = 0;
//        imaegView.transform = CGAffineTransformMakeScale(1.6, 1.6);
//    } completion:^(BOOL finished) {
//        [imaegView  removeFromSuperview];
//    }];
    

//    [self.view.window bringSubviewToFront:self]
//} completion:^(BOOL finished) {
//    [self.moreView removeFromSuperview];
//    [self.cover removeFromSuperview];
//    self.xiala = NO;
//}];
//return;
//}else{
//    // 1.添加按钮蒙板
//    UIButton *cover = [[UIButton alloc] init];
//    cover.frame = self.view.window.frame;
//    cover.backgroundColor = [UIColor blackColor];
//    [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
//    cover.userInteractionEnabled = YES;
//    // 控制UIButton的透明度
//    [cover setAlpha: 0.0];
//    [self.moreView setAlpha:0];
//    self.cover = cover;
//    [self.view.window addSubview:cover];
//    [self.view.window bringSubviewToFront:self.moreView];
    

//    [self setupSpecialView];
}
/**
 *  设置登录特效
 */
- (void)setupSpecialView{

}


#pragma mark - 懒加载
- (ZDMoreView *)moreView{
    if (!_moreView) {
        _moreView = [ZDMoreView moreView];
        self.moreView.y = self.moreView.y - self.moreView.height;
        self.moreView.center = self.view.center;
        self.moreView.borderType = BorderTypeDashed;
        self.moreView.dashPattern = 2;
        //    self.moreView.spacePattern = 2;
        self.moreView.borderWidth = 1;
        self.moreView.cornerRadius = 10;
        self.moreView.borderColor = [UIColor redColor];
        self.moreView.backgroundColor = ZDColor(255, 246, 229)
        self.moreView.delegate = self;
        [self.view.window  addSubview:_moreView];
    }
    return _moreView;
}

- (void)moreViewDidOK:(ZDMoreView *)moreView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.cover setAlpha:0];
        [self.moreView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.moreView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.xiala = NO;
    }];
}

- (void)moreViewDidWWW:(ZDMoreView *)moreView{
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)more{
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.cover setAlpha:0];
            [self.moreView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
            [self.cover removeFromSuperview];
            self.xiala = NO;
        }];
        return;
    }else{
        // 1.添加按钮蒙板
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = self.view.window.frame;
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
        cover.userInteractionEnabled = YES;
        // 控制UIButton的透明度
        [cover setAlpha: 0.0];
        [self.moreView setAlpha:0];
        self.cover = cover;
        [self.view.window addSubview:cover];
        [self.view.window bringSubviewToFront:self.moreView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.moreView setAlpha:1];
            [self.cover setAlpha: 0.65];
            // 监听蒙板点击事件
        } completion:^(BOOL finished) {
            self.xiala = YES;
        }];
        return;
    }
}
- (void)smallImage{
    
}

/** 加载上拉刷新和下拉刷新 */
- (void)setupRefresh
{
    // 添加Header上拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadIphoneNews)];
    
    // 添加Footer上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreIphoneNews)];
    // 首次登陆转菊花
    [self.tableView headerBeginRefreshing];
    //设置额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
}

- (void)loadIphoneNews{
    NSString *url = [NSString stringWithFormat:ZDIphoneNew20];
    [ZDHttpTool getWithUrl:url params:nil success:^(NSDictionary *dict) {
        self.dataList = dict[ZDIPhoneInfo];
        self.isMore = NO;
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)loadMoreIphoneNews{
    if (self.isMore) {
        [self.tableView footerEndRefreshing];
        [MBProgressHUD showMessage:@"暂无更多..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        return;
    }
    self.isMore = YES;
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1397116135282/20-40.html"];
    [ZDHttpTool getWithUrl:url params:nil success:^(NSDictionary *dict) {
        NSMutableArray *array = dict[ZDIPhoneInfo];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        [temp addObjectsFromArray:self.dataList];
        [temp addObjectsFromArray:array];
        self.dataList = temp;
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {                                                                                                                                                 
        [self.tableView footerEndRefreshing];
    }];
}

// 为表格注册可重用的cell
- (void)regCellNibs
{
    // 注册标题NIB
    UINib *titleNib = [UINib nibWithNibName:@"CZTitleCell" bundle:nil];
    [self.tableView registerNib:titleNib forCellReuseIdentifier:TitleCellID];
    
    // 注册其他NIB
    UINib *normalNib = [UINib nibWithNibName:@"CZNormalCell" bundle:nil];
    [self.tableView registerNib:normalNib forCellReuseIdentifier:NormalCellID];
    
    // 注册图集NIB
    UINib *PhotosNib = [UINib nibWithNibName:@"CZPhotosCell" bundle:nil];
    [self.tableView registerNib:PhotosNib forCellReuseIdentifier:PhotosID];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CZBaseCell *cell = nil;
    NSString *isPhotos = self.dataList[indexPath.row][@"docid"];
    NSArray *array = self.dataList[indexPath.row][@"imgextra"];
    NSRange range = [isPhotos rangeOfString:@"_" options:NSBackwardsSearch];
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:TitleCellID];
        cell = (CZTitleCell *)cell;
        CZTitleCell *titleCell = (CZTitleCell *)cell;
        titleCell.delegate = self;
    }else if (range.length != 0 | array.count!= 0 ){
        cell = [tableView dequeueReusableCellWithIdentifier:PhotosID];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
    }
    // 设置cell
    cell.dict = self.dataList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataList[indexPath.row][@"imgextra"];
    if (indexPath.row == 0) {
        return [CZTitleCell rowHeight];
    } else if(array.count!= 0){
        return [CZPhotosCell rowHeight];
    }else {
        return [CZNormalCell rowHeight];
    }
}

// 表格行选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    // imgextra
//    NSString *isPhotos = self.dataList[indexPath.row][@"docid"];
//    NSRange range = [isPhotos rangeOfString:@"_" options:NSBackwardsSearch];
     NSArray *array = self.dataList[indexPath.row][@"imgextra"];
    if (array.count != 0 ) {
        NSMutableArray *array = [NSMutableArray array];
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
        UIImageView *imageView2 = [[UIImageView alloc]init];
        UIImageView *imageView3 = [[UIImageView alloc]init];
        
        NSString *image1 = self.dataList[indexPath.row][@"imgsrc"];
        NSString *image2 = self.dataList[indexPath.row][@"imgextra"][0][@"imgsrc"];
        NSString *image3 = self.dataList[indexPath.row][@"imgextra"][1][@"imgsrc"];
        
        NSURL *url1 = [NSURL URLWithString:image1];
        [imageView1 sd_setImageWithURL:url1];
        NSURL *url2 = [NSURL URLWithString:image2];
        [imageView2 sd_setImageWithURL:url2];
        NSURL *url3 = [NSURL URLWithString:image3];
        [imageView3 sd_setImageWithURL:url3];
        MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
        
        
        
        MJPhoto *photo1 = [[MJPhoto alloc]init];
        photo1.url = [NSURL URLWithString:image1];
        photo1.srcImageView = imageView1;
        [array addObject:photo1];
        
        MJPhoto *photo2 = [[MJPhoto alloc]init];
        photo2.url = [NSURL URLWithString:image2];
        photo2.srcImageView = imageView2;
        [array addObject:photo2];
        
        MJPhoto *photo3 = [[MJPhoto alloc]init];
        photo3.url = [NSURL URLWithString:image3];
        photo3.srcImageView = imageView3;
        [array addObject:photo3];
        
        photoBrowser.photos = array;
        photoBrowser.currentPhotoIndex = 0;
        [photoBrowser show];
    }else {
        
        // 取出数据字典
        NSDictionary *dict = self.dataList[indexPath.row];
        // 1. 取出url
        NSString *url = dict[ZDURLKey];
        // 1> 取出url中的xxx.html
        // lastPathComponent取出最后一项内容
        NSString *fileName = [[url lastPathComponent] stringByDeletingPathExtension];
        
        for (UIViewController *controller in self.childViewControllers) {
            // 将子视图控制器的视图从父视图中删除
            [controller.view removeFromSuperview];
            // 将视图控制器从父视图控制器中删除
            [controller removeFromParentViewController];
        }
        
        // 新建文档视图控制器
        ZDDetailViewController *vc = [[ZDDetailViewController alloc] init];
        //    vc.articleURLStr = articleURLStr;
        vc.docid = fileName;
        vc.title = @"详细内容";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
