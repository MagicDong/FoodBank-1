//
//  ZDCategoryCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDCategoryCell.h"
@interface ZDCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UIView *xuanzhong;

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
    }
    return self;
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
        self.category.textColor = [UIColor colorWithRed:53 green:148 blue:57 alpha:1];
        self.xuanzhong.hidden = NO;
    }else{
        self.backgroundColor = ZDColor(53, 148, 57);
        self.category.textColor = [UIColor whiteColor];
        self.xuanzhong.hidden = YES;
    }
}


@end
