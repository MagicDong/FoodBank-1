//
//  ZDSiKuViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSiKuViewController.h"

@interface ZDSiKuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *anquan;
@property (weak, nonatomic) IBOutlet UIButton *guomin;
@property (weak, nonatomic) IBOutlet UIButton *jujue;
@property (weak, nonatomic) IBOutlet UIButton *weichangshi;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
/**
 *  当前选中食材库
 */
@property (nonatomic, weak) UIButton  *selectedBtn;
@end

@implementation ZDSiKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加四库";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    self.anquan.layer.cornerRadius = 3;
    self.anquan.layer.masksToBounds = YES;
    self.anquan.selected = YES;
    self.selectedBtn = self.anquan;
    
    self.guomin.layer.cornerRadius = 3;
    self.guomin.layer.masksToBounds = YES;
    
    self.jujue.layer.cornerRadius = 3;
    self.jujue.layer.masksToBounds = YES;
    
    self.weichangshi.layer.cornerRadius = 3;
    self.weichangshi.layer.masksToBounds = YES;
}

- (IBAction)anquan:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (IBAction)guomin:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (IBAction)jujue:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (IBAction)weichangshi:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}




@end
