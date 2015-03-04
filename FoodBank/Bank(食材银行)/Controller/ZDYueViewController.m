//
//  ZDYueViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDYueViewController.h"
#import "ZDBankBtn.h"
#import "ZDNetwork.h"

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
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                          }mutableCopy];
    NSString *str = [NSString stringWithFormat:@"经统计，本月宝宝的食材银行又新增安全食材 %d 个。\n\n有 %d 个食材发生了过敏；\n\n有 %d 个食材发生了拒绝，因此未进入到宝宝的食材银行，请您继续努力让宝宝尝试和熟悉多种多样的食物，增加食物的数量哦！",0,0,0];
    self.yuezongjie.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
//    self.zhouzongjie.userInteractionEnabled = YES;
    [ZDNetwork getYueCallback:^(RspState *rsp, NSDictionary *rspDict) {
        if(rsp.rspCode == 0){
            
            NSString *anquan = rspDict[@"anqun"];
            NSString *guomin = rspDict[@"guomin"];
            NSString *jujue  = rspDict[@"jujue"];

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineHeightMultiple = 10.f;
            paragraphStyle.maximumLineHeight = 20.f;
            paragraphStyle.minimumLineHeight = 20.f;
            paragraphStyle.alignment = NSTextAlignmentJustified;
            
            NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                                  }mutableCopy];
            NSString *str = [NSString stringWithFormat:@"经统计，本月宝宝的食材银行又新增安全食材 %@ 个。\n\n有 %@ 个食材发生了过敏；\n\n有 %@ 个食材发生了拒绝，因此未进入到宝宝的食材银行，请您继续努力让宝宝尝试和熟悉多种多样的食物，增加食物的数量哦！",anquan,guomin,jujue];
            self.yuezongjie.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
            
        }else{
            
            NSString *anquan = rspDict[@"anqun"];
            NSString *guomin = rspDict[@"guomin"];
            NSString *jujue  = rspDict[@"jujue"];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineHeightMultiple = 10.f;
            paragraphStyle.maximumLineHeight = 20.f;
            paragraphStyle.minimumLineHeight = 20.f;
            paragraphStyle.alignment = NSTextAlignmentJustified;
            
            NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                                  }mutableCopy];
            NSString *str = [NSString stringWithFormat:@"经统计，本月宝宝的食材银行又新增安全食材 %@ 个。\n\n有 %@ 个食材发生了过敏；\n\n有 %@ 个食材发生了拒绝，因此未进入到宝宝的食材银行，请您继续努力让宝宝尝试和熟悉多种多样的食物，增加食物的数量哦！",anquan,guomin,jujue];
            self.yuezongjie.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
        }
    }];
    
    self.yuezongjie.userInteractionEnabled = NO;
}


@end
