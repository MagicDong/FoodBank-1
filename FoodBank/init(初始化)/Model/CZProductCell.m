//
//  CZProductCell.m
//  01-网易彩票
//
//  Created by LNJ on 14-6-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZProductCell.h"
#import "CZProduct.h"

@interface CZProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end

@implementation CZProductCell

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
