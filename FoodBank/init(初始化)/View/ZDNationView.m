//
//  ZDNationView.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-26.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNationView.h"
@interface ZDNationView()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *NationView;
@property (strong, nonatomic) NSArray *nationArray;
@property (copy, nonatomic) NSString *result;
@end
@implementation ZDNationView

+ (instancetype)nationView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDNationView" owner:nil options:nil] lastObject];
}


- (NSArray *)nationArray{
    if (!_nationArray) {
        _nationArray = @[@"汉族",@"回族",@"维吾尔族",@"哈萨克族",@"乌兹别克族",@"塔吉克族",@"塔塔尔族",@"柯尔克孜族",@"撒拉族",@"东乡族",@"保安族",@"阿昌族",@"白族",@"布朗族",@"布依族",@"朝鲜族",@"达斡尔族",@"傣族",@"德昂族",@"侗族",@"独龙族",@"鄂伦春族",@"俄罗斯族",@"鄂温克族",@"高山族",@"仡佬族",@"哈尼族",@"赫哲族",@"基诺族",@"京族",@"景颇族",@"拉祜族",@"黎族",@"傈僳族",@"珞巴族",@"满族",@"毛南族",@"门巴族",@"蒙古族",@"苗族",@"仫佬族",@"纳西族",@"怒族",@"普米族",@"羌族",@"畲族",@"水族",@"土族",@"土家族",@"佤族",@"锡伯族",@"瑶族",@"彝族",@"裕固族",@"藏族",@"壮族"];
    }
    return _nationArray;
}

- (IBAction)Finish:(UIBarButtonItem *)sender
{
    SEL func = @selector(nationView:dateStr:);
    // 判断代理是否实现方法
    if ([self.delegate respondsToSelector:func]) {
        [self.delegate nationView:self dateStr:self.result];
    }
}

#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 如果是第0列，返回所有省份的数量
// 如果是第1列，返回选中的省份对应的城市数量
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.nationArray.count;
}

#pragma mark - 代理方法
// 返回列、行对应的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.nationArray[row];
}

// 选中行进行处理，根据选中的省份，重新加载城市数据
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = self.nationArray[row];
    self.result = str;
    SEL func = @selector(nationView:dateStr:);
    // 判断代理是否实现方法
    if ([self.delegate respondsToSelector:func]) {
        [self.delegate nationView:self dateStr:str];
    }
    
}



@end
