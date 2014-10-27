//
//  ZDAllergyViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-13.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDAllergyViewController.h"
#import "LBorderView.h"

@interface ZDAllergyViewController ()<UITextFieldDelegate>{
__weak IBOutlet LBorderView *_borderView1;
}
@property (weak, nonatomic) IBOutlet UITextField *qitaTextField;
@property (weak, nonatomic) IBOutlet UIButton *fuzhang;
@property (weak, nonatomic) IBOutlet UIButton *futong;
@property (weak, nonatomic) IBOutlet UIButton *pizhen;
@property (weak, nonatomic) IBOutlet UIButton *xiangbi;
@property (weak, nonatomic) IBOutlet UIButton *outu;
@property (weak, nonatomic) IBOutlet UIButton *xiesi;
@property (weak, nonatomic) IBOutlet UIButton *qita;
@property (weak, nonatomic) IBOutlet UIView *xuxian;
@property (nonatomic, strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UITextView *jianjie;

@end

@implementation ZDAllergyViewController
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.qitaTextField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"过敏反馈";
    self.qitaTextField.delegate = self;
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
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:202/255. green:57/255. blue:21/255. alpha:1]
                                  };
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    当孩子在新食材尝试中对某食材出现过敏现象后，请您带孩子去医院就医并遵医嘱自行安排对该食材的再次尝试时间。过敏食材的再次尝试应注意事项与方法，您可以去知识库进行查询；\n    当您准备好了给孩子再次尝试曾经过敏的食材，请对个人信息中的过敏食材库进行更新。并且该过敏食材再次尝试安全后，根据您的意见，我们可以将该食材从过敏食材库中移出并加入到安全食材库。" attributes:attributes];
}

- (IBAction)fuxie:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝的排便情况，若腹泻减轻，待正常后，间隔一段时间，适当减量再次添加，如没有问题，可按程序更换新食材。如仍有腹泻，此食物短期内不宜食用。若腹泻严重请到医院就医。建议您就医前将孩子的大便标本置于干净容器内同带往医院，以方便及时得到诊断。" attributes:attributes];
}

- (IBAction)fuzhang:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝的腹胀情况，若腹胀情况较轻，待宝宝腹胀完全消失后，间隔一段时间，适当减量再次添加，如仍有腹胀症状，此食物短期内不宜食用。若不再出现腹胀，可更换尝试添加其它食材。腹胀严重请及时就医确诊。" attributes:attributes];
}
- (IBAction)futong:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝的腹痛情况，若腹痛情况较轻，待宝宝腹痛完全消失后，间隔一段时间，适当减量再次添加，如仍有腹痛症状，此食物短期内不宜食用。若腹痛情况加重请及时就医确诊。" attributes:attributes];
}

- (IBAction)pizhen:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝皮疹的部位、面积及持续时间等情况，如皮疹状况逐步好转，待症状消失后，间隔一段时间，适当减量再次尝试，若皮疹不再出现，可更换尝试添加其它食材。若再次出现，此食物短期内不宜食用。若皮疹严重，面积逐步扩大，或持续不消失要及时就医确诊。" attributes:attributes];
}

- (IBAction)xiangbi:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝的睡眠情况，如睡眠较快恢复安稳，间隔一段时间，可适当减量再次尝试，若睡眠很好，可更换尝试添加其它食材。若再次出现睡眠不好的症状，证明宝宝对这种食材不适，短时期可以停止该食材的尝试。如宝宝睡眠仍不安稳，请及时就医确诊。" attributes:attributes];
    
}
- (IBAction)outu:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止食用该食材，观察宝宝的情况，如呕吐很快不再发生，间隔一段时间，适当减量再次尝试，若呕吐不再出现，可更换尝试添加其它食材。若再次出现，此食物短期内不宜食用。如呕吐未缓解或加重，请及时就医确诊引起呕吐的原因。" attributes:attributes];
}

- (IBAction)xiesi:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止给孩子继续食用该食材，观察宝宝的大便情况。如家长不易判断便中血丝的情况，请及时就医确诊。" attributes:attributes];
}
- (IBAction)qita:(UIButton *)sender {
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
    self.jianjie.attributedText = [[NSAttributedString alloc]initWithString:@"    请您立即停止给孩子继续食用该食材，观察宝宝的情况，注意宝宝的过敏症状的发展并酌情带宝宝就医确诊。" attributes:attributes];
    
}

- (IBAction)qitaTextField:(UITextField *)sender {
    
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.qitaTextField resignFirstResponder];
}


@end
