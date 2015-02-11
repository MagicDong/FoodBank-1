//
//  ZDYueViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDYueViewController.h"
#import "ZDBankBtn.h"

@interface ZDYueViewController ()
@property (weak, nonatomic) IBOutlet UITextView *yuezongjie;

@end

@implementation ZDYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"月总结";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
//    self.zhouzongjie.userInteractionEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 12.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    NSString *str = [NSString stringWithFormat:@"经统计，本月 %@ 的食材银行又新增安全食材 %@ 个。有 %@ 个食材发生了过敏；有 %@ 个食材发生了拒绝，因此未进入到宝宝的食材银行，请您继续努力让宝宝尝试和熟悉多种多样的食物，增加食物的数量哦！"];
    self.yuezongjie.attributedText = [[NSAttributedString alloc]initWithString:@"" attributes:attributes];
    
}


@end
