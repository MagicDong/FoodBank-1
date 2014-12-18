//
//  ZDKnowDetailCell.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDKnowModel;

@interface ZDKnowDetailCell : UITableViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableView;

@property (nonatomic, strong) ZDKnowModel *model;

@end
