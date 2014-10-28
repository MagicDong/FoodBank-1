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
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
