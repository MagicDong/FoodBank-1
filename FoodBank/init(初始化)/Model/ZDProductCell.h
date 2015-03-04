//
//  ZDProductCell.h
//  FoodBank
//
//  Created by apple-jiexian on 14/10/28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZProduct;

@interface ZDProductCell : UICollectionViewCell
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, strong) CZProduct *product;
@property (nonatomic, strong) NSDictionary *foodDict;
@end
