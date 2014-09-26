//
//  IWTabBarButton.m
//  传智微博
//
//  Created by apple on 14-7-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDChooseButton.h"

#define IWTitleButtonImageW 15

@interface ZDChooseButton()

@end

@implementation ZDChooseButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        // 1.设置图片居中
//        self.imageView.contentMode = UIViewContentModeCenter;
//        // 2.设置文字居中
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        // 3.设置文字大小
//        self.titleLabel.font = [UIFont systemFontOfSize:11];
//        
//        // 设置默认状态按钮的文字颜色
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        // 设置选中状态按钮的文字颜色
//        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        // 3.设置图片不拉伸
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 让系统高亮状态不调整图片的样式
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
// 控制按钮上标题显示的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    // 整个按钮的宽度 - 图片的宽度
    CGFloat titleW = self.width - IWTitleButtonImageW;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 控制按钮上图片显示的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = IWTitleButtonImageW;
    CGFloat imageX = self.width - imageW;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}



- (void)setHighlighted:(BOOL)highlighted{}

@end
