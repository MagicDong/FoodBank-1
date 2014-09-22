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
    // 1.创建对应自控制器的按钮
    ZDTabBarButton *btn = [[ZDTabBarButton alloc] init];
    
    // 2.设置按钮显示的内容
    btn.item = item;
    
    // 监听按钮点击事件
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 设置tag
    btn.tag = self.buttons.count;
    
    // 3.添加按钮到当前view
    [self addSubview:btn];
    
    // 4.将刚刚创建的选项卡按钮添加到数组中
    [self.buttons addObject:btn];
    
    // 5.设置默认选中
    if (self.buttons.count == 1) {
        //        btn.selected = YES;
        //        self.selectedBtn = btn;
        
        [self btnOnClick:btn];
    }
    
}

/**
 *  监听选项卡按钮点击
 */
- (void)btnOnClick:(ZDTabBarButton *)btn
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedFrom:to:)]) {
        // 传递上一次选中的按钮的tag, 和当前选中按钮的tag
        [self.delegate tabBar:self didSelectedFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    //    IWLog(@"btnOnClick");
    // 1.取消上次选中
    self.selectedBtn.selected = NO;
    // 2.选中本次
    btn.selected = YES;
    // 3.记录当前选中
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
