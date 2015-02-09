//
//  ZDTiaoKuanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 15/2/5.
//  Copyright (c) 2015年 Dong. All rights reserved.
//

#import "ZDTiaoKuanViewController.h"

@interface ZDTiaoKuanViewController ()

@property (weak, nonatomic) IBOutlet UIButton *biaoti;
@property (weak, nonatomic) IBOutlet UITextView *zhengwen;

@end

@implementation ZDTiaoKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户使用条款";
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.firstLineHeadIndent = 25.f;
    
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                          }mutableCopy];
    self.zhengwen.attributedText = [[NSAttributedString alloc]initWithString:@"欢迎访问“宝贝食材银行”，请在注册贺接受我们的服务前仔细阅读以下条款。\n您接受以下条款后方可接受“宝贝食材银行”的服务，请您仔细阅读。为遍历本服务条款叙述，以下也以“我们”代指“宝贝食材银行”。\n\n一、注册信息的保管和使用\n您提供的注册信息，我们将按照法律和相关规定，采取技术和制度的手段为您妥善保管。我们承诺仅根据“宝贝食材银行”服务的目的使用您的个人信息。除此之外，我们将对您的个人信息保密。如您认为我们超越了正常服务范畴使用了您的个人信息，请立即与客服中心联系，我们将核实纠正。\n\n二、政策发布和本服务条款变更\n如果我们发布新的服务政策，或者我们的服务政策或本服务条款有任何变更，我们将在“宝贝食材银行”上通知、公告或更改的方式进行，请您随时关注" attributes:attributes];
    self.zhengwen.editable = NO;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 12, w - 16, 30)];
    label.text = @"《宝贝食材银行APP用户服务条款》";
    label.textColor = ZDColor(55, 150, 66);
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:18]];
    [self.view addSubview:label];
    
//    NSLog(@"%f",self.biaoti.frame.origin.x);
//    NSLog(@"%f",self.biaoti.frame.origin.y);
}

@end
