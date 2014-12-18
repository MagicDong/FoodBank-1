//
//  LFCityPickerView.h
//  05-自定义选择城市控件
//
//  Created by LNJ on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFCityPickerViewDelegate <NSObject>

// 当用户选中某一个城市后，通知代理方，选中的城市即可
- (void)cityPickerViewDidSelectedCityName:(NSDictionary *)name;

@end

// 继承自UIPickerView，仍然需要数据源和代理来工作
@interface LFCityPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<LFCityPickerViewDelegate> cityDelegate;

// 根据传入的dataList，显示选择控件内容
// 让自己来做数据源和代理
// 系统的为什么不自己做数据源和代理？
@property (nonatomic, strong) NSArray *dataList;

@end
