//
//  ZDTabBar.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDTabBar;

@protocol ZDTabBarDelegate <NSObject>

@optional

- (void)tabBar:(ZDTabBar *)tabBar didSelectedButtonFrom:(NSInteger  )from to:(NSInteger)to;

@end


@interface ZDTabBar : UIView

/**
 *  提供一个方法给外加创建自定义IWTabBar的按钮
 *
 *  @param item 包含了(图片/选中图片/标题)的模型
 */
- (void)addTabBarButton:(UITabBarItem *)item;


@property (nonatomic, weak) id<ZDTabBarDelegate> delegate;

@end
