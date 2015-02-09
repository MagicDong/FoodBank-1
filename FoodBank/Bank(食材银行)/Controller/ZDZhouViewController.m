//
//  ZDZhouViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDZhouViewController.h"
#import "ZDBankBtn.h"

@interface ZDZhouViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tryFood;
@property (weak, nonatomic) IBOutlet UITextView *zhouzongjie;



@end

@implementation ZDZhouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"周总结";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
//    20,90
    self.zhouzongjie.userInteractionEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.firstLineHeadIndent = 25.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    self.zhouzongjie.attributedText = [[NSAttributedString alloc]initWithString:@"请您将宝宝父母已过敏（发生过敏、拒绝等现象）的食材勾选出来。" attributes:attributes];
}

@end
