//
//  IWCommonCell.h
//  传智微博
//
//  Created by apple on 14-7-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDCommonItem;

@interface ZDCommonCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 * 每一行对应的模型数据
 */
@property (nonatomic, strong) ZDCommonItem *item;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
