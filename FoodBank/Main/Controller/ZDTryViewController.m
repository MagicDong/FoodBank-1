//
//  ZDPlanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTryViewController.h"
#import "ZDTryChooseButton.h"

@interface ZDTryViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;   // 食材图片
@property (weak, nonatomic) IBOutlet UIButton *nameEdit;  // 换食材
@property (weak, nonatomic) IBOutlet UITextView *jieshao; // 食材介绍
@property (weak, nonatomic) IBOutlet UILabel *ke;         // 克数
@property (nonatomic, strong) UIImage *downImage;         // 向下图片
/**
 *  向上的图片
 */
@property (nonatomic, strong) UIImage *upImage;
@end

@implementation ZDTryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    ZDTryChooseButton *BtnBirthday = [[ZDTryChooseButton alloc]initWithFrame:CGRectMake(241, 76, 71, 40)];
    [BtnBirthday setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [BtnBirthday setTitle:@"3天" forState:UIControlStateNormal];
    [BtnBirthday addTarget:self action:@selector(tianBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BtnBirthday];
    
}

// 修改尝试周期按钮
- (void)tianBtnOnClick:(ZDTryChooseButton *)try{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (try.currentImage == self.downImage ) {
        // 向下 --> 向上
        [try setImage:self.upImage forState:UIControlStateNormal];
    }else{
        // 向上 --> 向下
        [try setImage:self.downImage forState:UIControlStateNormal];
    }
    UITableView *tian = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(try.frame), CGRectGetMaxY(try.frame), try.width, 100) style:UITableViewStylePlain];
    [self.view addSubview:tian];
    tian.delegate = self;
    tian.dataSource = self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)name:(id)sender {
    
}

- (IBAction)queding:(id)sender {
    
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
