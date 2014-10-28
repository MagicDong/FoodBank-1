//
//  ZDHelpViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDBankViewController.h"
#import "ZDZhouViewController.h"
#import "ZDYueViewController.h"
#import "ZDAnQuanViewController.h"
#import "ZDGuoMinViewController.h"
#import "ZDJiLuViewController.h"
#import "ZDRecordViewController.h"
#import "ZDJuJueViewController.h"
#import "ZDWeiChangShiViewController.h"
#import "viewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ZDMoreView.h"

@interface ZDBankViewController () <SCHCircleViewDataSource,SCHCircleViewDelegate,ZDMoreViewDelegate>
//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
/**
 *  时间选择
 */
@property (nonatomic , weak) ZDMoreView *moreView;
@property (nonatomic , assign) BOOL xiala;
/**
 *  蒙板
 */
@property (nonatomic , strong)UIButton *cover;
@end

@implementation ZDBankViewController

@synthesize circle_view = _circle_view;

- (IBAction)pressed:(id)sender
{
    [_circle_view reloadData];
}

#pragma mark - 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _icon_array = [[NSMutableArray alloc] init];
        [_icon_array addObject:[UIImage imageNamed:@"login_baobao"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_sina"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_qq"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_qq"]];
        [_icon_array addObject:[UIImage imageNamed:@"more_baobao_icon.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"more_baobao_icon.png"]];
        
    }
    return self;
}

#pragma mark - view
- (void)viewDidLoad
{
    [super viewDidLoad];
    _circle_view.circle_view_data_source = self;
    _circle_view.circle_view_delegate    = self;
    _circle_view.show_circle_style       = SChShowCircleWinding;
    [_circle_view reloadData];
    
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
    
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    
//    sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
//    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//    picker.delegate = self;
//    picker.allows Editing = YES;//设置可编辑
//    picker.sourceType = sourceType;
//    [self presentViewController:picker animated:YES completion:nil];
//
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        
//        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;  //是否可编辑
//        //摄像头
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];
//    }else{
//        //如果没有提示用户
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
//        [alert show];
//    }
    // 3.添加更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
}

- (void)more{
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
            //            self.moreView.y = self.moreView.y - self.moreView.height;
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

#pragma mark - 懒加载
- (ZDMoreView *)moreView{
    if (!_moreView) {
        _moreView = [ZDMoreView moreView];
        self.moreView.y = self.moreView.y - self.moreView.height;
        self.moreView.center = self.view.center;
        self.moreView.borderType = BorderTypeDashed;
        self.moreView.dashPattern = 2;
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

#pragma mark - SCHCircleViewDataSource
- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    if(Inch4){
        return CGPointMake(self.view.width / 2, (self.view.width /2) + 20);
    }
    
    return CGPointMake(self.view.width / 2, (self.view.width /2));
}

- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view
{
    return _icon_array.count;
}

- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell
{
  
    if(self.circle_view.is_single_tap_animation){return nil;}
    viewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"viewCell" owner:nil options:nil] lastObject];
    [cell.image_view setImage:[_icon_array objectAtIndex:index_circle_cell]];
    return cell;
}

#pragma mark - 图片点击事件代理 安全、过敏、记录、周总结、月总结
- (void)touchBeginCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index{
    if(self.circle_view.is_single_tap_animation){return ;}
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.58 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (index == 0) {
            ZDAnQuanViewController *anquan = [[ZDAnQuanViewController alloc]init];
            [self.navigationController pushViewController:anquan animated:YES];
        }else if (index == 1){
            ZDGuoMinViewController *guomin = [[ZDGuoMinViewController alloc]init];
            [self.navigationController pushViewController:guomin animated:YES];
        }else if (index == 2){
            ZDZhouViewController *zhou = [[ZDZhouViewController alloc]init];
            [self.navigationController pushViewController:zhou animated:YES];
        }else if (index == 3){
            ZDYueViewController *yue = [[ZDYueViewController alloc]init];
            [self.navigationController pushViewController:yue animated:YES];
        }else if (index == 4){
            ZDJuJueViewController *jujue = [[ZDJuJueViewController alloc]init];
            [self.navigationController pushViewController:jujue animated:YES];
        }else if (index == 5){
            ZDWeiChangShiViewController *weichangshi = [[ZDWeiChangShiViewController alloc]init];
            [self.navigationController pushViewController:weichangshi animated:YES];
        }
    });
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
