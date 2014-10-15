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
#import "ZDKnowTableViewController.h"

@interface ZDRejectViewController (){
    __weak IBOutlet LBorderView *_borderView1;
}
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *jianjie;
@property (nonatomic, strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *zhishiku;

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

    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    当宝宝拒绝尝试这个新食材时，家长应尊重宝宝的意见，立即停止食用此食材。因为有可能孩子只是因为身体不舒服、情绪不好等临时原因而不愿意食用此食材。若家长坚持，可能真的会造成宝宝对这个食材厌恶而拒绝。如果当时家长没有坚持，在经过1个月的忘却期后再给孩子重新尝试，宝宝可能就顺利接受了。请家长尽量找出拒绝的原因，以便下一次尝试时能够避免该情况发生。" attributes:attributes];
    self.jianjie.editable = NO;
    self.jianjie.scrollEnabled = YES;
    self.jianjie.scrollsToTop = YES;
}
- (IBAction)zhishiku:(UIButton *)sender {
    ZDKnowTableViewController *know = [[ZDKnowTableViewController alloc]init];
    [self.navigationController pushViewController:know animated:YES];
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    您别着急，这可能是宝宝此时不太饿，应给宝宝建立定时定量吃饭的好习惯。待宝宝经过一个月忘却期后，“营养管家”会安排宝宝再次尝试该食材，请选择在宝宝身体健康、情绪愉快的时候尝试。\n  1、宝宝不饿，不想吃新食材时该怎么办？" attributes:attributes];
    self.jianjie.scrollsToTop = YES;
    
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    建宝宝的情绪不好只是个临时原因。您不要着急，待宝宝经过一个月的忘却期后，您可以选择一个宝宝身体健康、情绪愉快的时机再次给宝宝尝试。放心吧！到时“营养管家”会提醒您的。" attributes:attributes];
    self.jianjie.scrollsToTop = YES;
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    建议您可以尝试以下的方法，帮助宝宝接受新食材。\n    ①为宝宝选择形状可爱的、颜色漂亮且浅一些的勺子给宝宝喂食；\n    ②开始喂食时，勺子只要伸进宝宝嘴巴里一点点就可以了，如果伸得太深，可能会使他作呕。宝宝有了这样不愉快的经历就更加抗拒勺子；\n    ③可以先用勺子喂一些宝宝比较熟悉的食物如奶、水等，等宝宝熟悉了再用勺子喂新食物。您不要着急，待宝宝经过一个月忘却期后，“营养管家”会安排宝宝再次尝试该食材，请选择在宝宝身体健康、情绪愉快的时候尝试。\n  " attributes:attributes];
    self.jianjie.scrollsToTop = YES;
    
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    建议您可以尝试以下的方法，帮助宝宝接受新食材。\n    1. 选择一个孩子喜欢吃的食物与需要尝试的新食材搭配着吃。这样孩子接受的几 率会大些；\n    2. 对新食材进行趣味制作后再试着给孩子尝试添加；\n    3. 选择有趣的餐具来引起宝宝对新食材的兴趣" attributes:attributes];
    self.jianjie.scrollsToTop = YES;
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请按照制作方法的指导制作食物，这样孩子就容易接受了。您别着急，待宝宝经过一个月忘却期后，我们可以选择一个宝宝身体好、情绪愉快的时机再次给宝宝尝试。放心吧！到时我们会提醒您的。\n" attributes:attributes];
    self.jianjie.scrollsToTop = YES;
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    宝宝的情绪不好只是个临时原因。您不要着急，待宝宝经过一个月的忘却期后，您可以选择一个宝宝身体健康、情绪愉快的时机再次给宝宝尝试。放心吧！到时“营养管家”会提醒您的。" attributes:attributes];
    self.jianjie.scrollsToTop = YES;
}
- (IBAction)isOK:(UIButton *)sender {
    
}


@end
