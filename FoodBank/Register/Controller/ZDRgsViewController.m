//
//  ZDRgsViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-23.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRgsViewController.h"
#import "ZDDatePickerView.h"

@interface ZDRgsViewController () <ZDDatePickerViewDelegate>

/**
 *  时间选择
 */
@property (nonatomic ,weak) ZDDatePickerView *datePickerView;

@end

@implementation ZDRgsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
}

#pragma mark - 懒加载
- (ZDDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [ZDDatePickerView datePickerView];
        _datePickerView.center = self.view.center;
        // 设置代理
        _datePickerView.delegate = self;
        [self.view addSubview:_datePickerView];
    }
    return _datePickerView;
}

@end
