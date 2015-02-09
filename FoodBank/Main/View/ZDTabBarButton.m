//
//  ZDTabBarButton.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTabBarButton.h"
#import "UIImage+ZD.h"

// 图标的比例
#define IWTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  IWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  IWTabBarButtonTitleSelectedColor (iOS7 ? IWColor(180, 177, 177) : IWColor(248, 139, 0))
/** 是否为4英寸屏 */
#define Inch4 ([UIScreen mainScreen].bounds.size.height >= 568.0)
/** 是否为4.7英寸屏 */
#define Inch47 ([UIScreen mainScreen].bounds.size.height >= 667.0)
/** 是否为5.5英寸屏 */
#define Inch55 ([UIScreen mainScreen].bounds.size.height >= 736.0)
@implementation ZDTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
//        self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = ZDWeiRuan(11);
        // 文字颜色
        UIColor *hui = ZDColor(180, 177, 177);
        UIColor *lv = ZDColor(53, 147, 58);
        [self setTitleColor:hui forState:UIControlStateNormal];
        [self setTitleColor:lv forState:UIControlStateSelected];
        
        if (!iOS7) { // 非iOS7下,设置按钮选中时的背景
            [self setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
    }
    return self;
}
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

//// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width * 0.5;
    CGFloat imageH = contentRect.size.height * IWTabBarButtonImageRatio;
    CGFloat padding = 15;
    if (Inch55) {
        padding = 20;
    }else if (Inch47){
        padding = 18;
    }
    return CGRectMake(padding, 5, imageW , imageH);
    
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * IWTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY+3, titleW, titleH);
    
}

@end
