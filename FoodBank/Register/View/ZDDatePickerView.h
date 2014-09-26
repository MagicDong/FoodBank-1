//
//  CZDatePickerView.h
//  01-网易彩票
//
//  Created by LNJ on 14-6-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 子控件：委托方
 1. 定义协议
 2. 定义代理
 3. 在需要时，通知代理工作
 */

@class ZDDatePickerView;

@protocol ZDDatePickerViewDelegate <NSObject>

- (void)datePickerView:(ZDDatePickerView *)picker dateStr:(NSString *)dateStr;

@end

@interface ZDDatePickerView : UIView

+ (instancetype)datePickerView;

@property (nonatomic, weak) id <ZDDatePickerViewDelegate> delegate;

@end
