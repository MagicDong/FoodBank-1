//
//  ZDPlanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTryViewController.h"
#import "ZDTryChooseButton.h"
#import "ZDTuiJianViewController.h"
#import "ZDEditViewController.h"
#import "ZDMoreView.h"
#import "MBProgressHUD+ZD.h"

@interface ZDTryViewController () <UITableViewDataSource,UITableViewDelegate,ZDMoreViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;   // 食材图片
@property (weak, nonatomic) IBOutlet UIButton *nameEdit;  // 换食材
@property (weak, nonatomic) IBOutlet UITextView *jieshao; // 食材介绍
@property (weak, nonatomic) IBOutlet UILabel *ke;         // 克数
@property (nonatomic, strong) UIImage *downImage;         // 向下图片
@property (nonatomic, strong) UIImage *upImage;           // 向上的图片
@property (nonatomic, strong) UITableView *table;         // 点击按钮出来天数
@property (weak, nonatomic) IBOutlet UITextView *jieshaoTextView;
@property (weak, nonatomic) IBOutlet UITextView *tuijianTextView;
@property (nonatomic, strong) UIButton *tianBtn;
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

@implementation ZDTryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
    ZDTryChooseButton *tianBtn = [[ZDTryChooseButton alloc]initWithFrame:CGRectMake(241, 76, 71, 40)];
    [tianBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [tianBtn setTitle:@"3天" forState:UIControlStateNormal];
    [tianBtn addTarget:self action:@selector(tianBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tianBtn];
    self.tianBtn = tianBtn;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 10.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]
                                  };
    
    self.jieshaoTextView.attributedText = [[NSAttributedString alloc]initWithString:@"这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！这是一根好黄瓜！" attributes:attributes];
    self.jieshaoTextView.editable = NO;
    self.jieshaoTextView.backgroundColor = [UIColor clearColor];
    
    self.tuijianTextView.attributedText = [[NSAttributedString alloc]initWithString:@"直接吃就行！" attributes:attributes];
    self.tuijianTextView.editable = NO;
    self.tuijianTextView.backgroundColor = [UIColor clearColor];
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


// 修改尝试周期按钮
- (void)tianBtnOnClick:(ZDTryChooseButton *)try{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (try.currentImage == self.downImage ) {
        // 向下 --> 向上
        [try setImage:self.upImage forState:UIControlStateNormal];
        UITableView *tian = [[UITableView alloc]initWithFrame:CGRectMake(226, CGRectGetMaxY(try.frame), 91, 150) style:UITableViewStylePlain];
        [self.view addSubview:tian];
        tian.alpha= 0;
        tian.delegate = self;
        tian.dataSource = self;
        self.table = tian;
        [UIView animateWithDuration:0.5f animations:^{
            tian.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        // 向上 --> 向下
        [try setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"7天";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"6天";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"5天";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"4天";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"3天";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [self.tianBtn setTitle:@"7天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==1) {
        [self.tianBtn setTitle:@"6天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==2) {
        [self.tianBtn setTitle:@"5天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==3) {
        [self.tianBtn setTitle:@"4天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==4) {
        [self.tianBtn setTitle:@"3天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;

        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (IBAction)name:(id)sender {
    ZDEditViewController *edit = [[ZDEditViewController alloc]init];
    [self.navigationController  pushViewController:edit animated:YES];
}

- (IBAction)queding:(id)sender {
    [MBProgressHUD showError:@"该食材正在尝试中.."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.62 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
  
}

- (UIImage *)downImage
{
    if (!_downImage) {
        _downImage = [UIImage imageWithNamed:@"navigationbar_arrow_down"];
    }
    return _downImage; 
}

- (UIImage *)upImage
{
    if (!_upImage) {
        _upImage = [UIImage imageWithNamed:@"navigationbar_arrow_up"];
    }
    return _upImage;
}
@end
