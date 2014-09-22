//
//  IWCommonCell.m
//  传智微博
//
//  Created by apple on 14-7-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDCommonCell.h"
#import "ZDCommonItem.h"
#import "ZDCommonLabelItem.h"
#import "ZDCommonSwitchItem.h"
#import "ZDCommonArrowItem.h"
#import "ZDBadgeButton.h"
#import "ZDCommonCheckItem.h"

@interface ZDCommonCell()
/**
 * 开关
 */
@property (nonatomic, strong) UISwitch *rightSwitch;
/**
 * Label
 */
@property (nonatomic, strong) UILabel *rightLabel;
/**
 * 剪头
 */
@property (nonatomic, strong) UIImageView *rightArrow;
/**
 * 提醒数字
 */
@property (nonatomic, strong) ZDBadgeButton *badgeButton;

/**
 * 打勾
 */
@property (nonatomic, strong) UIImageView *rightChecked;

@property (nonatomic, weak) UITableView  * tableView;
@end

@implementation ZDCommonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置文字大小
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        // 2.设置子标题的位置
//        self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
//        self.detailTextLabel.backgroundColor = [UIColor redColor];
        
        // 3.设置背景图片
        // backgroundView的优先级大于backgroundColor
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc ] init];
        self.selectedBackgroundView = [[UIImageView alloc ] init];
        
        // 4.设置iOS6下高亮状态的颜色
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor
        ;
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    ZDCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZDCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.tableView = tableView;
    }
    return cell;
}

- (void)setItem:(ZDCommonItem *)item
{
    _item = item;
    
    // 1.设置图标
    self.imageView.image = [UIImage imageWithNamed:_item.icon];
    // 2.设置标题
    self.textLabel.text = _item.title;
    // 3.设置子标题
    self.detailTextLabel.text = _item.subtitle;
    // 4.设置辅助视图的类型
    [self setupRigth];
    
}
/**
 * 设置辅助视图的类型
 */
- (void)setupRigth
{
    
    // 判断模型的类型, 根据模型的类型来确定右边显示什么控件
    if (self.item.badgeValue.intValue) {
        // 显示提醒数字
//        self.accessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        self.badgeButton.badgeValue = self.item.badgeValue;
        
        self.accessoryView = self.badgeButton;
        
    }else if ([self.item isKindOfClass:[ZDCommonLabelItem class]]) {
        // 设置右边为label
        self.accessoryView = self.rightLabel;
        
        // 1.设置label上显示的文字
        ZDCommonLabelItem *item = (ZDCommonLabelItem *)self.item;
        self.rightLabel.text = item.text;
        // 2.设置label的size

        self.rightLabel.size = [item.text sizeWithFont:self.rightLabel.font];
        
    }else if ([self.item isKindOfClass:[ZDCommonSwitchItem class]])
    {
        // 设置右边为switch
        self.accessoryView = self.rightSwitch;
        
    }else if ([self.item isKindOfClass:[ZDCommonArrowItem class]])
    {
        // 设置右边为剪头
        self.accessoryView = self.rightArrow;
    }else if ([self.item isKindOfClass:[ZDCommonCheckItem class]])
    {
        // 设置右边为打勾
        // 1.取出对应行的模型
        ZDCommonCheckItem *item = (ZDCommonCheckItem *)self.item;
        // 2.判断是否需要显示打勾
        if (item.isChecked) {
            self.accessoryView = self.rightChecked;
        }else
        {
            self.accessoryView = nil;
        }
    }
    else
    {
        // 没有辅助视图
        self.accessoryView = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 根据行号设置背景图片
    // 获取背景图片
    UIImageView *normalBg = (UIImageView *)self.backgroundView;
    UIImageView *selectedBg = (UIImageView *)self.selectedBackgroundView;
    
    // 获取当前组一共有多少行
    NSInteger totalRow =  [self.tableView numberOfRowsInSection:indexPath.section];
    
    if (1 == totalRow) {
        // 当前组只有一行数据
        normalBg.image = [UIImage resizableImageNamed:@"common_card_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_background_highlighted"];
        
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
        
    }else if (0 == indexPath.row) {
        // 是当前这一组的第0行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_top_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_top_background_highlighted"];
        
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
        
    }else if ((totalRow - 1) == indexPath.row)
    {
        // 是当前组的最后一行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_bottom_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_bottom_background_highlighted"];
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
    }else
    {
        // 中间的行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_middle_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_middle_background_highlighted"];

        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
    }
}

#pragma mark - 拦截系统设置cell的frame, 然后修改cell的Y值
- (void)setFrame:(CGRect)frame
{
//    frame.origin.y -= 25;
    /*
     {{0, 35}, {320, 44}}  第一个cell
     {{0, 79}, {320, 44}}
     {{0, 133}, {320, 44}}
     */
//    IWLog(@"%@", NSStringFromCGRect(frame));
    if (!iOS7) {
        frame.origin.x -= 10;
        frame.size.width += 20;
    }
    
    [super setFrame:frame];
}

#pragma mark - 懒加载
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UIImageView *)rightChecked
{
    if (!_rightChecked) {
        _rightChecked = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"common_icon_checkmark"]];
    }
    return _rightChecked;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (UISwitch *)rightSwitch
{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}
- (ZDBadgeButton *)badgeButton
{
    if (!_badgeButton) {
        _badgeButton = [[ZDBadgeButton alloc] init];
    }
    return _badgeButton;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
//    IWLog(@"layoutSubviews = %@", NSStringFromCGRect(self.contentView.frame));
    // 设置子标题的位置
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}

@end
