//
//  LFCityPickerView.m
//  05-自定义选择城市控件
//
//  Created by LNJ on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "LFCityPickerView.h"
//#import "LFProvinces.h"
#import "ZDDataTool.h"

@implementation LFCityPickerView

- (id)init
{
    self = [super init];
    if (self) {
        // 设置

    }
    return self;
}
- (void)awakeFromNib{
    self.delegate = self;
    self.dataSource = self;
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    
    // 刷新pickerView，重新调用数据源方法
    [self reloadAllComponents];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 返回每一列对应的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 如果是第0列，返回数组的数量
    if (component == 0) {
#pragma mark 第0行调用
        return [ZDDataTool dataWithClassID:0];
    } else if(component == 1){
        // 取出当前选中的第0列选中的行
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
#pragma mark 第1行调用
        return [ZDDataTool dataWithCategoryID:selectedRow];
    }else{
#pragma mark 第2行调用
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        NSInteger selectedRow2 = [pickerView selectedRowInComponent:1];
        return [ZDDataTool dataWithClassID:selectedRow categoryID:selectedRow2];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - 代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 如果是第0列，返回省份名称
    if (component == 0) {
        NSArray *array = [ZDDataTool dataWithStringClassID:0];
        return array[row][@"name"];
    } else if(component == 1){
        // 如果是第1列，返回选中省份对应的城市的名称
        // 取出当前选中的第0列选中的行
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        NSArray *array = [ZDDataTool dataWithStringCategoryID:selectedRow];
        return array[row][@"name"];
    }else if(component == 2){
        // 如果是第2列，返回选中省份对应的城市的名称
        // 取出当前选中的第1列选中的行
        NSInteger selectedRow  = [pickerView selectedRowInComponent:0];
        NSInteger selectedRow1 = [pickerView selectedRowInComponent:1];
        NSArray *array = [ZDDataTool dataWithStringClassID:selectedRow categoryID:selectedRow1];
        return array[row][@"food_name"];
    }else{
//        NSLog(@"sdfksdfks dfk kk kkk k k");
        return @"";
    }
}

// 选中行的代理方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 如果是第0列被选中,需要刷新第一列的数据
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }else if(component == 1){
        [pickerView reloadComponent:2];
    }
    // 获取用户选中的数据
    // 1> 用户在第0列选中的行->省
    NSInteger pIndex = [pickerView selectedRowInComponent:0];
    // 2> 用户在第1列选中的行->城市
    NSInteger cIndex = [pickerView selectedRowInComponent:1];
    // 2> 用户在第1列选中的行->城市
    NSInteger kIndex = [pickerView selectedRowInComponent:2];
    NSArray *array = [ZDDataTool dataWithStringClassID:pIndex categoryID:cIndex];
    if (array.count != 0) {
        NSDictionary *dict = array[kIndex];
//        NSString *str = dict[@"food_name"];
//        NSLog(@"%@",str);
        [self.cityDelegate cityPickerViewDidSelectedCityName:dict];
    }
//    NSLog(@"...%@",str);
//    NSLog(@"%@ %@", pName, cName);
    // 通知代理方选中的城市名称
}

@end
