//
//  ZDKnowCell.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZDKnowCell : UITableViewCell

@property (nonatomic, strong) NSString *dict;
@property (nonatomic, assign) NSInteger row;
+ (instancetype)cellWithTableview:(UITableView *)tableView;


@end
