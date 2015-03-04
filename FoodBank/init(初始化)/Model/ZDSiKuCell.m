//
//  ZDSiKuCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-28.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDSiKuCell.h"
#import "ZDSiKuButton.h"

@interface ZDSiKuCell()
@property (weak, nonatomic) IBOutlet ZDSiKuButton *sikuBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sikuImage;
@end
@implementation ZDSiKuCell
- (void)awakeFromNib {
    CALayer *layer = [self.sikuImage layer];
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 1.0f; 
}
- (IBAction)sikuBtn:(UIButton *)sender
{
    
}

@end
