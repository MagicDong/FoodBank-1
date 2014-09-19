//
//  UIImage+CZ.h
//  05-小画板
//
//  Created by LNJ on 14-6-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZD)

/** 截取指定视图中的图片(拍图) */
+ (UIImage *)captureFromView:(UIView *)view;
/**
 *  创建一个已经适配好了iOS67的图片
 *
 *  @param name 图片名称
 */
+ (instancetype)imageWithNamed:(NSString *)name;

/**
 *  创建一个拉伸不变形的图片 默认左0.5 上0.5
 *
 *  @param name 图片名称
 */
+ (instancetype)resizableImageNamed:(NSString *)name;

/**
 *  创建一个拉伸不变形的图片 自定义拉伸范围  左  上
 */
+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
