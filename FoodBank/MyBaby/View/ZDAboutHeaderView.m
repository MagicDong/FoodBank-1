//
//  ILAboutHeaderView.m
//
//  Created by mj on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ZDAboutHeaderView.h"

@implementation ZDAboutHeaderView

+ (instancetype)aboutHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZDAboutHeaderView" owner:nil options:nil][0];
    
//    UIFont *font = [UIFont fontWithName:(@"1") size:(1)];//字体名，和大小来初始化。
//    UIFont *font = [UIFont fontNamesForFamilyName:(NSString*)];//从设备支持的字体的名字中选择。
//    UIFont *font = [UIFont systemFontOfSize:(CGDloat)];//通过字体大小来设置字体
//    UIFont *font = [UIFont boldSystemFontOfSize:(CGFloat)];//默认大小粗体字
    
    
}

@end
