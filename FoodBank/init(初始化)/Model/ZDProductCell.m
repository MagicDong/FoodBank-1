//
//  ZDProductCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/10/28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDProductCell.h"
#import "CZProduct.h"

@interface ZDProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end

@implementation ZDProductCell

// 用模型设置UI
- (void)setProduct:(CZProduct *)product
{
    
    _product = product;
    
    self.iconView.image = [UIImage imageNamed:product.icon];
    
    // 设置圆角半径
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;
    
    self.title.text = product.title;
    
}
@end
