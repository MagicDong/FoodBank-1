//
//  ZDLoginSexCell.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDLoginSexCell.h"
#import "ZDBabyTool.h"
#import "ZDBaby.h"

@interface ZDLoginSexCell()

/** 之前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;

@end
@implementation ZDLoginSexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
    self.isNan = baby.sex;
    if (self.isNan) {
        self.nan.selected = YES;
        self.selectedButton = self.nan;
        self.nv.selected = NO;
    }else{
        self.nan.selected = NO;
        self.selectedButton = self.nv;
        self.nv.selected = YES;
    }
}

- (IBAction)nan:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    self.isNan = YES;
}
- (IBAction)nv:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    self.isNan = NO;
}

@end
