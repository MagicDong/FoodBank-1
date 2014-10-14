//
//  ZDRejectViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-13.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRejectViewController.h"
#import "LBorderView.h"
#import "HBVLinkedTextView.h"
#import "UIColor+HBVHarmonies.h"

@interface ZDRejectViewController (){
    __weak IBOutlet LBorderView *_borderView1;
}
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *jianjie;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation ZDRejectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拒绝反馈";
    _borderView1.borderType = BorderTypeDashed;
    _borderView1.dashPattern = 1;
    _borderView1.spacePattern = 1.5;
    _borderView1.borderWidth = 0.3;
    //    _borderView1.cornerRadius = 10;
    _borderView1.borderColor = [UIColor redColor];
    
    self.jianjie.textColor = ZDColor(202, 57, 21);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                         }mutableCopy];

    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    您别着急，这可能是宝宝此时不太饿，应给宝宝建立定时定量吃饭的好习惯。待宝宝经过一个月忘却期后，“营养管家”会安排宝宝再次尝试该食材，请选择在宝宝身体健康、情绪愉快的时候尝试。\n1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];

}

- (LinkedStringTapHandler)exampleHandlerWithTitle:(NSString *)title
{
    LinkedStringTapHandler exampleHandler = ^(NSString *linkedString) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                       message:[NSString stringWithFormat:@"Handle tap in linked string '%@'",linkedString]
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil, nil];
        [alert show];
//        [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
    };
    
    return exampleHandler;
}

- (IBAction)choose1:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    您别着急，这可能是宝宝此时不太饿，应给宝宝建立定时定量吃饭的好习惯。待宝宝经过一个月忘却期后，“营养管家”会安排宝宝再次尝试该食材，请选择在宝宝身体健康、情绪愉快的时候尝试。\n  1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];
    
    
}
- (IBAction)choose2:(UIButton *)sender {
    
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    建议您可以尝试以下的方法，帮助宝宝接受新食材。\n  1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];
    
}
- (IBAction)choose3:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    建议您可以尝试以下的方法，帮助宝宝接受新食材。\n    ①为宝宝选择形状可爱的、颜色漂亮且浅一些的勺子给宝宝喂食；\n    ②开始喂食时，勺子只要伸进宝宝嘴巴里一点点就可以了，如果伸得太深，可能会使他作呕。宝宝有了这样不愉快的经历就更加抗拒勺子；\n    ③可以先用勺子喂一些宝宝比较熟悉的食物如奶、水等，等宝宝熟悉了再用勺子喂新食物。您不要着急，待宝宝经过一个月忘却期后，“营养管家”会安排宝宝再次尝试该食材，请选择在宝宝身体健康、情绪愉快的时候尝试。\n  1、宝宝拒绝喂饭的小匙怎么办？\n  1、为什么要坚持用小勺和碗喂宝宝？\n更多内容请点击知识库查看" attributes:attributes];
    
}
- (IBAction)choose4:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    宝宝的情绪不好只是个临时原因。您不要着急，待宝宝经过一个月的忘却期后，您可以选择一个宝宝身体健康、情绪愉快的时机再次给宝宝尝试。放心吧！到时“营养管家”会提醒您的。\n  1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];
    
}
- (IBAction)choose5:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    宝宝的情绪不好只是个临时原因。您不要着急，待宝宝经过一个月的忘却期后，您可以选择一个宝宝身体健康、情绪愉快的时机再次给宝宝尝试。放心吧！到时“营养管家”会提醒您的。\n  1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];
    
}
- (IBAction)choose6:(UIButton *)sender {
    // 取消之前选中按钮的选中状态
    self.selectedButton.selected = NO;
    
    // 设置点中按钮的selected ＝ YES
    sender.selected = YES;
    
    // 将当前按钮作为选中按钮
    self.selectedButton = sender;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    宝宝的情绪不好只是个临时原因。您不要着急，待宝宝经过一个月的忘却期后，您可以选择一个宝宝身体健康、情绪愉快的时机再次给宝宝尝试。放心吧！到时“营养管家”会提醒您的。\n  1、宝宝不饿，不想吃新食材时该怎么办？\n更多内容请点击知识库查看" attributes:attributes];
    
}
- (IBAction)isOK:(UIButton *)sender {
    
}


@end
