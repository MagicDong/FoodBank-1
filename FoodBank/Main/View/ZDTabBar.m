//
//  ZDTabBar.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-19.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTabBar.h"
#import "ZDTabBarButton.h"

@interface ZDTabBar()


/**
 *  定义数组保存所有的选项卡按钮
 */
@property (nonatomic, strong) NSMutableArray *buttons;
// 懒加载 : 1.用到的时候才加载(节约内存空间)  2.将创建对象的代码封装到一个方法中

/**
 *  定义属性保存选中按钮
 */
@property (nonatomic, weak) ZDTabBarButton  * selectedBtn;
@end

@implementation ZDTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置选项卡按钮的frame
    [self setupTabBarButtonFrame];
}
/**
 *  设置选项卡按钮的frame
 */
- (void)setupTabBarButtonFrame
{
    // 便利选项卡按钮设置frame
    NSInteger count = self.buttons.count;
    CGFloat height = self.height;
    CGFloat width = self.width / (self.buttons.count);
    for (int i = 0; i < count; i++) {
        // 1.取出对应位置的按钮
        UIButton *btn = self.buttons[i];
        // 2.设置frame
        btn.height = height;
        btn.width =  width;// 加上添加按钮
        btn.y = 0;
        btn.x = i * btn.width;
    }
}

/**
 *  添加选项卡按钮
 */
- (void)addTabBarButton:(UITabBarItem *)item
{

    ZDTabBarButton *btn = [[ZDTabBarButton alloc] init];
    
    btn.item = item;
    
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchDown];
    
    btn.tag = self.buttons.count;
    
    [self addSubview:btn];
    
    [self.buttons addObject:btn];
    
    if (self.buttons.count == 1) {
        [self btnOnClick:btn];
    }
    
}

/**
 *  监听选项卡按钮点击
 */
- (void)btnOnClick:(ZDTabBarButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedBtn.tag to:btn.tag];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

#pragma mark - 懒加载
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

@end
