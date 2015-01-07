//
//  ZDKnowInfoViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowInfoViewController.h"
#import "LBorderView.h"
#import "HBVLinkedTextView.h"
#import "UIColor+HBVHarmonies.h"

@interface ZDKnowInfoViewController ()
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *textView;
@property (weak, nonatomic) IBOutlet LBorderView *borderView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *isOK;

@end

@implementation ZDKnowInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细";
    self.label.text = self.dict[@"title"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    self.textView.attributedText = [[NSAttributedString alloc]initWithString:self.dict[@"detail"] attributes:attributes];
    self.textView.backgroundColor = ZDColor(255, 246, 229);
    
}


- (void)viewDidAppear:(BOOL)animated{
    self.borderView.borderType = BorderTypeDashed;
    self.borderView.dashPattern = 2;
    self.borderView.spacePattern = 2;
    self.borderView.borderWidth = 1;
    self.borderView.cornerRadius = 10;
    self.borderView.borderColor = [UIColor redColor];
    self.borderView.backgroundColor = ZDColor(255, 246, 229);
//        轻微
//        景天
//    飞蓬     天妖皇
//    夕瑶      太武
//剑圣              徐长卿
//重楼               一贫
}

- (IBAction)isOK:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
