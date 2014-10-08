//
//  ZDTryChooseButton.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-8.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTryChooseButton.h"

#define IWTitleButtonImageW 15

@implementation ZDTryChooseButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        // 让系统高亮状态不调整图片的样式
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Judge"]];
        
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

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 1.调用父类方法设置标题
    [super setTitle:title forState:state];
    
}

- (void)setHighlighted:(BOOL)highlighted{}


@end
