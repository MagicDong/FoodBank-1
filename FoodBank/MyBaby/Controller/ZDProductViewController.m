//
//  ZDProductViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14/10/27.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDProductViewController.h"

@interface ZDProductViewController ()
@property (weak, nonatomic) IBOutlet UITextView *product;

@end

@implementation ZDProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品推荐";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                  };
    self.product.attributedText = [[NSAttributedString alloc]initWithString:@"感谢您使用免费版宝贝食材银行APP\n登录活好网站，了解更多资讯，更多强大的营养配餐软件期待您的使用！\n通过对应接口您可直接将此APP中的食材库信息导入到其他软件中方便您的使用。" attributes:attributes];
}
- (IBAction)yinshijilu:(id)sender {
    NSString *appid = @"725296055";
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
    NSURL *url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)WWW:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)iPad:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"iPad版优膳有方正在开发中,请问您是否期待？" delegate:self cancelButtonTitle:@"非常期待！" otherButtonTitles:@"期待！", nil];
    [alertView show];
}

- (IBAction)yingyangcheng:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"宝贝营养秤正在开发中,请问您是否期待？" delegate:self cancelButtonTitle:@"非常期待！" otherButtonTitles:@"期待！", nil];
    [alertView show];
}

- (IBAction)baobeichizhongxue:(UIButton *)sender {
    NSString *appid = @"725296055";
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
    NSURL *url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}


@end
