//
//  CZProductCell.m
//
//  Created by LNJ on 14-6-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZProductCell.h"
#import "CZProduct.h"
#import "SDWebImageManager+MJ.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

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
- (void)setFoodDict:(NSDictionary *)foodDict{
    _foodDict = foodDict;
    
    NSString *iconStr = [NSString stringWithFormat:@"http://192.168.1.250/mimag/%@.png",foodDict[@"mid"]];
    NSURL *url = [NSURL URLWithString:iconStr];
    [self.iconView sd_setImageWithURL:url];
    
    self.title.text = foodDict[@"mname"];
    self.mid = foodDict[@"mid"];
//    self.selectBtn.selected = NO;
}
- (void)setSelectArray:(NSArray *)selectArray{
    _selectArray = selectArray;
    
    
    NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:self.mid, nil];
    
    /*
     方法一：利用NSPredicate
     注：NSPredicate所属Cocoa框架，在密码、用户名等正则判断中经常用到。
     类似于SQL语句
     NOT 不是
     SELF 代表字符串本身
     IN 范围运算符
     那么NOT (SELF IN %@) 意思就是：不是这里所指定的字符串的值
     */
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
    //过滤数组
    NSArray * reslutFilteredArray = [_selectArray filteredArrayUsingPredicate:filterPredicate];
    if ([_selectArray isEqualToArray:reslutFilteredArray]) {
        self.selectBtn.selected = NO;
    }else{
        self.selectBtn.selected = YES;
    }
}

@end
