//
//  ZDChooseButton.m
//
//  Created by apple on 14-7-6.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDChooseButton.h"

#define IWTitleButtonImageW 15

@interface ZDChooseButton()

@end

@implementation ZDChooseButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        // 让系统高亮状态不调整图片的样式
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        // 设置选中状态按钮的文字颜色
//        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
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
    
    // 2.根据外界传入的标题计算按钮的宽度
    // 2.1计算文字的宽度
//    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
//    IWLog(@"setTitle = %.1f", titleSize.width);
    
//     2.2计算按钮的宽度
//    self.width = titleSize.width + 2 * IWTitleButtonImageW;
    
}


//- (void)setHighlighted:(BOOL)highlighted{}

@end
