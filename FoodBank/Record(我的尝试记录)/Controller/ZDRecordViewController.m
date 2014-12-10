 //
//  ZDRecordViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRecordViewController.h"
#import "YGPSegmentedController.h"
#import "AppDelegate.h"
#import "LBorderView.h"
#import <QuartzCore/QuartzCore.h>
#import "ZDAllergyViewController.h"
#import "ZDRejectViewController.h"
#import "ZDPresentViewController.h"
#import "ChoiceButton.h"
#import "MBProgressHUD+ZD.h"
#import "ZDMoreView.h"
#import "ZDTuiJianViewController.h"


@interface ZDRecordViewController ()<ZDMoreViewDelegate>
{
    YGPSegmentedController * _ygp;
    UILabel * label;
    __weak IBOutlet LBorderView *_borderView1;
}

/** 之前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet ChoiceButton *anquan;
@property (weak, nonatomic) IBOutlet ChoiceButton *guomin;
@property (weak, nonatomic) IBOutlet ChoiceButton *jujue;
@property (weak, nonatomic) IBOutlet ChoiceButton *weichangshi;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UILabel *babyYue;
@property (weak, nonatomic) IBOutlet UILabel *toDay;
@property (weak, nonatomic) IBOutlet UILabel *zhouqi;

@property (nonatomic, assign) BOOL isIng;
/**
 *  蒙板
 */
@property (nonatomic, strong)UIButton *cover;
/**
 *  时间选择
 */
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@end

@implementation ZDRecordViewController

- (IBAction)queren:(UIButton *)sender {
    if ([self.selectedButton.titleLabel.text isEqualToString:@"安全"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已将次食材添加到宝贝安全食材库。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if ([self.selectedButton.titleLabel.text isEqualToString:@"过敏"]){
        ZDAllergyViewController *allergy = [[ZDAllergyViewController alloc]init];
        [self.navigationController pushViewController:allergy animated:YES];
    }else if ([self.selectedButton.titleLabel.text isEqualToString:@"拒绝"]){
        ZDRejectViewController *reject = [[ZDRejectViewController alloc]init];
        [self.navigationController pushViewController:reject animated:YES];
    }else if([self.selectedButton.titleLabel.text isEqualToString:@"未尝试"]){
          
    }
    if (self.selectedButton == nil) {
        [MBProgressHUD showError:@"您还没有选择尝试情况"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
        
    });
}


- (IBAction)present:(UIButton *)sender {
    NSDictionary *foodInfo = @{@"foodName":self.foodName.text,@"zhouqi":self.zhouqi.text,@"toDay":self.toDay.text};
    ZDTuiJianViewController *present = [[ZDTuiJianViewController alloc]init];
    present.foodInfo = foodInfo;
    [self.navigationController pushViewController:present animated:YES];
    
}

- (IBAction)anquan:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
}

- (IBAction)guomin:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
}


- (IBAction)jujue:(UIButton *)sender {
    // 取消之前选中按钮的选中状态 
    self.selectedButton.selected = NO;
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
}

- (IBAction)weichangshi:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self anquan:nil];
    self.title = @"尝试记录";
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithObjects:@"10月12日", @"10月13日", @"10月14日", @"10月15日", @"10月16日", @"10月17日", @"10月18日",nil];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    /*
     第一个参数是存放你需要显示的title
     第二个是设置你需要的size
     */
    _ygp = [[YGPSegmentedController alloc]initContentTitle:TitielArray CGRect:CGRectMake(0, 60, self.view.width, 44)];
    [_ygp setDelegate:self];
    [self.view addSubview:_ygp];
    [_ygp initselectedSegmentIndex];
    
//    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 200)];
//    label.font=[UIFont boldSystemFontOfSize:50.0];
//    [self.view addSubview:label];
    
    _borderView1.borderType = BorderTypeDashed;
    _borderView1.dashPattern = 2;
    _borderView1.spacePattern = 2;
    _borderView1.borderWidth = 1;
    _borderView1.cornerRadius = 10;
    _borderView1.borderColor = [UIColor redColor];
    _borderView1.backgroundColor = ZDColor(255, 246, 229);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
}

- (void)more{
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
            // 监听蒙板点击事件
            [self.moreView setAlpha:1];
            [self.cover setAlpha: 0.65];
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [_ygp initselectedSegmentIndex];
    
}

-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl == _ygp) {
        switch (index) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                break;
            case 5:
                break;
            case 6:
                break;
            default:
                break;
        }
    }
    NSString * string = [NSString stringWithFormat:@"%d",index];
    label.text=string;
}

@end
