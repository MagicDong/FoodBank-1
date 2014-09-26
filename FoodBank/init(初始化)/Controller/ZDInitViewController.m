//
//  ZDInitViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-25.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDInitViewController.h"
#import "ZDChooseButton.h"

@interface ZDInitViewController ()

@property (weak, nonatomic) IBOutlet ZDChooseButton *BtnBirthday;
@property (weak, nonatomic) IBOutlet ZDChooseButton *BtnNation;
@property (weak, nonatomic) IBOutlet ZDChooseButton *BtnAllergy;
/**
 *  向下的图片
 */
@property (nonatomic, strong) UIImage *downImage;
/**
 *  向上的图片
 */
@property (nonatomic, strong) UIImage *upImage;

@end

@implementation ZDInitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"初始化";
    UIImage *image = [UIImage imageNamed:@"navigationbar_arrow_down"];
    [self.BtnBirthday  setImage:image forState:UIControlStateNormal];
    [self.BtnBirthday addTarget:self action:@selector(birthdayBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
}

- (void)birthdayBtnOnClick:(ZDChooseButton *)titleBtn
{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (self.BtnBirthday.currentImage == self.downImage) {
        // 向下 --> 向上
        [self.BtnBirthday setImage:self.upImage forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25 animations:^{

        }];
    }else
    {
        // 向上 --> 向下
        [self.BtnBirthday setImage:self.downImage forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25 animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    }
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

- (IBAction)BtnBirthday:(UIButton *)sender {
    
}

- (IBAction)BtnNation:(UIButton *)sender {
    
}

- (IBAction)BtnAllergy:(UIButton *)sender {
    
}
@end
