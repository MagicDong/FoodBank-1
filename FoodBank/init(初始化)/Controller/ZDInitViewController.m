//
//  ZDInitViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-25.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDInitViewController.h"
#import "ZDChooseButton.h"
#import "ZDDatePickerView.h"
#import "ZDJudgeViewController.h"
#import "ZDNavViewController.h"
#import "ZDNationView.h"
#import "ZDNetwork.h"
#import "MBProgressHUD+ZD.h"
#import "NSDate+ZD.h"

@interface ZDInitViewController () <ZDDatePickerViewDelegate,ZDNationViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *userView;

/**
 *  向下的图片
 */
@property (nonatomic, strong) UIImage *downImage;
/**
 *  向上的图片
 */
@property (nonatomic, strong) UIImage *upImage;
/**
 *  生日按钮
 */
@property (nonatomic, strong)  ZDChooseButton *BtnBirthday;
/**
 *  民族按钮
 */
@property (nonatomic, strong)  ZDChooseButton *BtnNation;

/**
 *  过敏按钮
 */
@property (nonatomic, strong)  ZDChooseButton *BtnAllergy;
/**
 *  时间选择
 */
@property (nonatomic ,strong) ZDDatePickerView *datePickerView;
/**
 *  时间选择
 */
@property (nonatomic ,strong) ZDNationView *nationView;

@end

@implementation ZDInitViewController


- (IBAction)Finish:(UIButton *)sender {
    NSString *nation = @"1";
    if([self.BtnNation.titleLabel.text isEqualToString:@"汉族"]){
        nation = @"1";
    }else if ([self.BtnNation.titleLabel.text isEqualToString:@"回族"]){
        nation = @"3";
    }else if ([self.BtnNation.titleLabel.text isEqualToString:@"回族"]){
        nation = @"11";
    }else if ([self.BtnNation.titleLabel.text isEqualToString:@"请选择宝宝民族"]){
        [MBProgressHUD showError:@"请选择宝宝民族"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        return;
    }else{
        nation = @"0";
    }
    

    
    [MBProgressHUD showMessage:@"提交初始化中..."];
    if ([self.BtnNation.titleLabel.text isEqualToString:@"请选择宝宝出生日期"]){
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"请选择宝宝出生日期"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        return;
    }else{
        [MBProgressHUD hideHUD];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //设置日期格式
        NSDate *today = [NSDate date]; //当前日期
        NSDate *newDate = [dateFormatter dateFromString:self.BtnBirthday.titleLabel.text];  //开始日期，将NSString转为NSDate
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:newDate toDate:today options:0];
        if (cmps.day >= 120) {
            [ZDNetwork  postBabyInfoWithBirthday:self.BtnBirthday.titleLabel.text nation:nation allergy:@"" CallBack:^(RspState * rsp) {
                if (rsp.rspCode == 0) {
                    
                }
            }];
            ZDJudgeViewController *judge = [[ZDJudgeViewController alloc]init];
            [self.navigationController pushViewController:judge animated:YES];
        }else{
            [MBProgressHUD showError:@"宝宝月龄未达到标准"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
            return;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"宝宝基本信息";
    UIImage *image = self.downImage;
    ZDChooseButton *BtnBirthday = [[ZDChooseButton alloc]initWithFrame:CGRectMake(51, 9, 221, 40)];
    [BtnBirthday setImage:image forState:UIControlStateNormal];
    [BtnBirthday setTitle:@"请选择宝宝出生日期" forState:UIControlStateNormal];
    [BtnBirthday addTarget:self action:@selector(birthdayBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.userView addSubview:BtnBirthday];
    self.BtnBirthday = BtnBirthday;
    
    ZDChooseButton *BtnNation = [[ZDChooseButton alloc]initWithFrame:CGRectMake(51, 60, 221, 40)];
    [BtnNation setImage:image forState:UIControlStateNormal];
    [BtnNation setTitle:@"请选择宝宝民族" forState:UIControlStateNormal];
    [BtnNation addTarget:self action:@selector(nationBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.userView addSubview:BtnNation];
    self.BtnNation = BtnNation;
    
    ZDChooseButton *BtnAllergy = [[ZDChooseButton alloc]initWithFrame:CGRectMake(51, 112, 221, 40)];
    [BtnAllergy setImage:image forState:UIControlStateNormal];
    [BtnAllergy setTitle:@"请选择父母过敏食材" forState:UIControlStateNormal];
    [BtnAllergy addTarget:self action:@selector(allergyBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.userView addSubview:BtnAllergy];
    self.BtnAllergy = BtnAllergy;
    
    self.navigationItem.leftBarButtonItem = nil;
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
//    汉族、回族、维吾尔族、哈萨克族、乌兹别克族、塔吉克族、塔塔尔族、柯尔克孜族、撒拉族、东乡族、保安族、阿昌族、白族 、布朗族 、布依族 、朝鲜族、达斡尔族、傣族、德昂族、侗族、独龙族、鄂伦春族 、俄罗斯族、鄂温克族、高山族、仡佬族、哈尼族、赫哲族、基诺族、京族、景颇族、拉祜族、黎族、傈僳族、珞巴族、满族、毛南族、门巴族、蒙古族、苗族、仫佬族、纳西族、怒族、普米族、羌族、畲族、水族、土族、土家族、佤族、锡伯族 、瑶族、彝族、裕固族、藏族、壮族
}

#pragma mark - ZDDatePickerViewDelegate
/** 生日选择完毕点击确定 */
- (void)datePickerView:(ZDDatePickerView *)picker dateStr:(NSString *)dateStr
{
    // 向上 --> 向下
    [self.BtnBirthday setTitle:dateStr forState:UIControlStateNormal];
    [self.BtnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BtnBirthday setImage:self.downImage forState:UIControlStateNormal];
    self.datePickerView.y = self.view.height - self.datePickerView.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.datePickerView.y = self.view.height;
        
    } completion:^(BOOL finished) {
        [self.datePickerView removeFromSuperview];
    }];
}


/** 点击生日 */
- (void)birthdayBtnOnClick:(ZDChooseButton *)titleBtn
{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (titleBtn.currentImage == self.downImage ) {
        // 向下 --> 向上
        _datePickerView = [ZDDatePickerView datePickerView];
        _datePickerView.y = self.view.height;
        // 设置代理
        _datePickerView.delegate = self;
        [self.view addSubview:_datePickerView];
        
        [titleBtn setImage:self.upImage forState:UIControlStateNormal];
        self.datePickerView.y = self.view.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.datePickerView.y = self.view.height - self.datePickerView.height;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        // 向上 --> 向下
        [titleBtn setImage:self.downImage forState:UIControlStateNormal];
        self.datePickerView.y = self.view.height - self.datePickerView.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.datePickerView.y = self.view.height;
        } completion:^(BOOL finished) {
            [self.datePickerView removeFromSuperview];
        }];
    }
}

- (void)nationBtnOnClick:(ZDChooseButton *)titleBtn
{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (titleBtn.currentImage == self.downImage) {
        // 向下 --> 向上
        
        _nationView = [ZDNationView nationView];
        _nationView.y = self.view.height;
        // 设置代理
        _nationView.delegate = self;
        [self.view addSubview:_nationView];
        
        [titleBtn setImage:self.upImage forState:UIControlStateNormal];
        self.nationView.y = self.view.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.nationView.y = self.view.height - self.nationView.height;
        } completion:^(BOOL finished) {
            
        }];
    }else
    {
        // 向上 --> 向下
        [titleBtn setImage:self.downImage forState:UIControlStateNormal];
        self.nationView.y = self.view.height - self.nationView.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.nationView.y = self.view.height;
        } completion:^(BOOL finished) {
            [self.nationView removeFromSuperview];
        }];
    }
}

- (void)nationView:(ZDNationView *)picker dateStr:(NSString *)dateStr{
    // 向上 --> 向下
    [self.BtnNation setTitle:dateStr forState:UIControlStateNormal];
    [self.BtnNation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BtnNation setImage:self.downImage forState:UIControlStateNormal];
    self.datePickerView.y = self.view.height - self.datePickerView.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.datePickerView.y = self.view.height;
    } completion:^(BOOL finished) {
        [self.datePickerView removeFromSuperview];
    }];
}

- (void)nationView:(ZDNationView *)picker ok:(NSString *)dateStr{
    // 向上 --> 向下
    if(dateStr == nil){
        dateStr = @"汉族";
    }
    
    [self.BtnNation setTitle:dateStr forState:UIControlStateNormal];
    [self.BtnNation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BtnNation setImage:self.downImage forState:UIControlStateNormal];
    self.datePickerView.y = self.view.height - self.datePickerView.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.datePickerView.y = self.view.height;
    } completion:^(BOOL finished) {
        [self.nationView removeFromSuperview];
    }];
}

- (void)allergyBtnOnClick:(ZDChooseButton *)titleBtn
{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (titleBtn.currentImage == self.downImage) {
        // 向下 --> 向上
        [titleBtn setImage:self.upImage forState:UIControlStateNormal];
            
        [UIView animateWithDuration:0.25 animations:^{
            
        }];
    }else
    {
        // 向上 --> 向下
        [titleBtn setImage:self.downImage forState:UIControlStateNormal];
            
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

#pragma mark - 懒加载
- (ZDDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [ZDDatePickerView datePickerView];
        _datePickerView.y = self.view.height;
        // 设置代理
        _datePickerView.delegate = self;
        [self.view addSubview:_datePickerView];
    }
    return _datePickerView;
}


- (ZDNationView *)nationView
{
    if (!_nationView) {
        _nationView = [ZDNationView nationView];
        _nationView.y = self.view.height;
        // 设置代理
        _nationView.delegate = self;
        [self.view addSubview:_nationView];
    }
    return _nationView;
}

@end
