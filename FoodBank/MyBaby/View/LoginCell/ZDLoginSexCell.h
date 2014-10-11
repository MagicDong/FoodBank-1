//
//  ZDLoginSexCell.h
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDBaseCell.h"

@interface ZDLoginSexCell : ZDBaseCell
@property (weak, nonatomic) IBOutlet UIButton *nan;
@property (weak, nonatomic) IBOutlet UIButton *nv;

@property (nonatomic ,assign) BOOL isNan;

@end
