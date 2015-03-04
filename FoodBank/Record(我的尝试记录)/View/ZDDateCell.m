//
//  ZDCategoryCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDDateCell.h"
#import "IWBadgeButton.h"

@interface ZDDateCell ()

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UIView *xuanzhong;
@property (nonatomic, strong) IWBadgeButton *badgeBtn;
@end
@implementation ZDDateCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = ZDColor(53, 148, 57);
    self.category.font = [UIFont fontWithName:@"MicrosoftYaHei" size:(17)];
    self.category.textColor = [UIColor colorWithRed:53 green:148 blue:57 alpha:1];
    
    // 添加红色原点按钮
    IWBadgeButton *badgeBtn = [[IWBadgeButton alloc] init];
    [self addSubview:badgeBtn];
    self.badgeBtn = badgeBtn;
    badgeBtn.hidden = YES;
}

+ (instancetype)categoryCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDDateCell" owner:nil options:nil] lastObject];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置红色原点的位置
    self.badgeBtn.y = 0;
    self.badgeBtn.x = self.width - self.badgeBtn.width -1;
    self.badgeBtn.width = 25;
    self.badgeBtn.height = 25;
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
        self.badgeBtn.hidden = YES;
    }else{
        self.backgroundColor = ZDColor(53, 148, 57);
        self.category.textColor = [UIColor whiteColor];
        self.xuanzhong.hidden = YES;
        if (self.badgeBtn.titleLabel.text.intValue) {
            self.badgeBtn.hidden = NO;
        }else{
            self.badgeBtn.hidden = YES;
        }

    }
    // 让self监听_item的badgeValue属性的改变
    /*
     NSKeyValueObservingOptionNew = 返回最新的值给我们
     NSKeyValueObservingOptionOld = 返回原始的值给我们
     NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld 返回原始的和最新的值给我们
     */
//    [self addObserver:self forKeyPath:@"bage" options:0 context:nil];

}
- (void)setBage:(NSInteger)bage{
//    NSLog(@"%ld",(long)bage);
    _badgeBtn.badgeValue = [NSString stringWithFormat:@"%d",(int)bage];
    
//    if (bage) {
//        // 有未读消息
//        self.badgeBtn.hidden = NO;
//        
//        NSString *value = nil;
//        if (bage >= 100) {
//            
//            value = @"N";
//        }else
//        {
//            value = badgeValue;
//        }
//        [self setTitle:value forState:UIControlStateNormal];
//        
//    }else
//    {
//        self.hidden = YES;
//    }
//}
}



@end
