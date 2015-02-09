//
//  ZDCategoryCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDCategoryCell.h"
#import "IWBadgeButton.h"

@interface ZDCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UIView *xuanzhong;
@property (nonatomic, strong) IWBadgeButton *badgeBtn;
@end
@implementation ZDCategoryCell

- (void)awakeFromNib {
    
}

+ (instancetype)categoryCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDCategoryCell" owner:nil options:nil] lastObject];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ZDColor(53, 148, 57);
        self.category.font = [UIFont boldSystemFontOfSize:13];
        self.category.textColor = [UIColor colorWithRed:53 green:148 blue:57 alpha:1];
        
        // 添加红色原点按钮
        IWBadgeButton *badgeBtn = [[IWBadgeButton alloc] init];
        [self addSubview:badgeBtn];
        self.badgeBtn = badgeBtn;
        badgeBtn.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置红色原点的位置
    self.badgeBtn.y = 0;
    self.badgeBtn.x = self.width - self.badgeBtn.width - 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.category.text = title;
}
- (void)setZhuangtai:(NSInteger)zhuangtai{
    _zhuangtai = zhuangtai;
    if (zhuangtai) {
        self.backgroundColor = [UIColor whiteColor];
        self.category.textColor = ZDColor(53, 148, 57);
        self.xuanzhong.hidden = NO;
    }else{
        self.backgroundColor = ZDColor(53, 148, 57);
        self.category.textColor = [UIColor whiteColor];
        self.xuanzhong.hidden = YES;
    }
    // 让self监听_item的badgeValue属性的改变
    /*
     NSKeyValueObservingOptionNew = 返回最新的值给我们
     NSKeyValueObservingOptionOld = 返回原始的值给我们
     NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld 返回原始的和最新的值给我们
     */
    [_xuanzhong addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
}
- (void)dealloc
{
    [_xuanzhong removeObserver:self forKeyPath:@"badgeValue"];
}


@end
