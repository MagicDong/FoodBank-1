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
#import "viewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ZDBankViewController () <SCHCircleViewDataSource,SCHCircleViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ZDBankViewController

@synthesize circle_view = _circle_view;

- (IBAction)pressed:(id)sender
{
    [_circle_view reloadData];
}

#pragma mark -
#pragma mark - 初始化

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        _icon_array = [[NSMutableArray alloc] init];
        [_icon_array addObject:[UIImage imageNamed:@"login_baobao"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_sina"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_qq"]];
        [_icon_array addObject:[UIImage imageNamed:@"tab004"]];
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
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
//    sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
//    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//    picker.delegate = self;
//    picker.allowsEditing = YES;//设置可编辑
//    picker.sourceType = sourceType;
//    [self presentViewController:picker animated:YES completion:nil];
//
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
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
            ZDJiLuViewController *jilu = [[ZDJiLuViewController alloc]init];
            [self.navigationController pushViewController:jilu animated:YES];
        }else if (index == 3){
            ZDZhouViewController *zhou = [[ZDZhouViewController alloc]init];
            [self.navigationController pushViewController:zhou animated:YES];
        }else if (index == 4){
            ZDYueViewController *yue = [[ZDYueViewController alloc]init];
            [self.navigationController pushViewController:yue animated:YES];
        }
    });
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
