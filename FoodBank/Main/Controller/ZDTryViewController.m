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

@interface ZDTryViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;   // 食材图片
@property (weak, nonatomic) IBOutlet UIButton *nameEdit;  // 换食材
@property (weak, nonatomic) IBOutlet UITextView *jieshao; // 食材介绍
@property (weak, nonatomic) IBOutlet UILabel *ke;         // 克数
@property (nonatomic, strong) UIImage *downImage;         // 向下图片
@property (nonatomic, strong) UIImage *upImage;           // 向上的图片
@property (nonatomic, strong) UITableView *table;         // 点击按钮出来天数
@property (nonatomic, strong) UIButton *tianBtn;
@end

@implementation ZDTryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    ZDTryChooseButton *tianBtn = [[ZDTryChooseButton alloc]initWithFrame:CGRectMake(241, 76, 71, 40)];
    [tianBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [tianBtn setTitle:@"3天" forState:UIControlStateNormal];
    [tianBtn addTarget:self action:@selector(tianBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tianBtn];
    self.tianBtn = tianBtn;
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
    
}

- (IBAction)queding:(id)sender {
    ZDTuiJianViewController *tuijian = [[ZDTuiJianViewController alloc]init];
    [self.navigationController pushViewController:tuijian animated:YES];
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
