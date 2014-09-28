//
//  ZDSiKuButton.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSiKuButton.h"
#define IWTitleButtonImageW 20
@implementation ZDSiKuButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        // 让系统高亮状态不调整图片的样式
        self.adjustsImageWhenHighlighted = NO;
        UIColor *color = ZDColor(100, 103, 61);
        [self setImage:[UIImage imageNamed:@"user_checkbox_seleted"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"user_checkbox"] forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    return self;
}

// 控制按钮上标题显示的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY =  0;
    CGFloat titleX =  self.width *0.4;
    // 整个按钮的宽度 - 图片的宽度
    CGFloat titleW = self.width *0.6;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 控制按钮上图片显示的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = IWTitleButtonImageW;
    CGFloat imageX = 0;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setLabel:(NSString *)label{
    _label = label;
    
    self.titleLabel.text = _label;
    [self setTitle:_label forState:UIControlStateNormal];
    [self setTitle:_label forState:UIControlStateSelected];
}
- (void)setHighlighted:(BOOL)highlighted{}

@end
