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
        self.backgroundColor = ZDColor(240, 241, 244);
        self.category.font = [UIFont boldSystemFontOfSize:14];
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
        self.category.textColor = [UIColor redColor];
    }else{
        self.backgroundColor = ZDColor(240, 241, 244);
        self.category.textColor = [UIColor blackColor];
    }
}


@end
