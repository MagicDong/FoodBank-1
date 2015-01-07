//
//  CZProductCell.h
//  01-网易彩票
//
//  Created by LNJ on 14-6-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZProduct;

@interface CZProductCell : UICollectionViewCell

@property (nonatomic, strong) CZProduct *product;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, strong) NSDictionary *foodDict;
@property (nonatomic, strong) NSArray *guominArray;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) NSArray *selectArray;

@end
