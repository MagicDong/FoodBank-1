//
//  UIImage+CZ.m
//
//  Created by LNJ on 14-6-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+ZD.h"

@implementation UIImage (ZD)

/** 截取指定视图中的图片(拍图) */
+ (UIImage *)captureFromView:(UIView *)view
{
    // 1> 开始图像上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 2> 取得的当前上下文就是图像上下文本身了
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 3> 使用图层渲染输出图像到上下文
    [view.layer renderInContext:ctx];
    
    // 4> 拿到图像
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5> 关闭图像上下文
    UIGraphicsEndImageContext();
    
    return result;
}
/** 以拼接_os7方式适配 IOS7图片 */
+ (instancetype)imageWithNamed:(NSString *)name
{
    // 0.定义返回的对象
    UIImage *image = nil;
    
    // 1.判断是否是iOS7
    if (iOS7) {
        // 要在图片名称后面拼接_os7
        NSString *iOS7Name = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:iOS7Name];
    }
    // 2.判断图片是否为nil(因为有的图片是iOS67通用, 没有_os7结尾的图片)
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    // 3.返回图片
    return image;
}

/** 类方法传入一个图片名 返回一张拉伸好的图片 */
+ (instancetype)resizableImageNamed:(NSString *)name
{
    return [self resizableImageNamed:name left:0.5 top:0.5];
}

/* 通过一个类方法传入一个图片名和拉伸范围 返回一个拉伸好的图片 */
+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)leftRatio top:(CGFloat)topRatio
{
    UIImage *image = [UIImage imageWithNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

@end
