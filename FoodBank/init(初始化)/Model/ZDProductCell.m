//
//  ZDProductCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/10/28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDProductCell.h"
#import "CZProduct.h"
#import "SDWebImageManager+MJ.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

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
//{"foodGenre":"谷类","foodGenreList":[["55","薏米","薏米"]]},
- (void)setFoodDict:(NSDictionary *)foodDict{
    _foodDict = foodDict;
    
    NSString *iconStr = [NSString stringWithFormat:@"http://192.168.1.250/mimag/%@.png",foodDict[@"mid"]];
    NSURL *url = [NSURL URLWithString:iconStr];
    [self.iconView sd_setImageWithURL:url];
    
    self.title.text = foodDict[@"mname"];
    self.mid = foodDict[@"mid"];
    //    self.selectBtn.selected = NO;
}
@end
