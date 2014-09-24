//
//  ZDSearchBar.m
//  新浪微博
//
//  Created by Dong on 14-7-8.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDSearchBar.h"

@implementation ZDSearchBar



- (void)awakeFromNib{

    // 设置文字对齐样式
    self.textAlignment = NSTextAlignmentLeft;
//    // 设置提示文字
//    self.placeholder = @"搜索";
    // 设置删除按钮
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleNone;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.returnKeyType = UIReturnKeySearch;
}


- (void)setImg:(NSString *)img{
    _img = img;
    UIImage *image = [UIImage imageWithNamed:img];
    UIImageView *icon = [[UIImageView alloc]initWithImage:image];
    // 图片的宽
    icon.width = 30;
    icon.x = 10;
    icon.height = 30;
    icon.contentMode = UIViewContentModeCenter;
    self.leftView = icon;
}
- (void)setTishi:(NSString *)tishi{
    _tishi = tishi;
    // 设置提示文字
//    self.placeholder = tishi;
}

@end
