//
//  ZDZhouViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDZhouViewController.h"
#import "ZDBankBtn.h"
#import "ZDNetwork.h"

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
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                          }mutableCopy];
    NSString *str = [NSString stringWithFormat:@"本周您给宝宝尝试了 %d 个新食材，为：\n\n %@。\n\n恭喜您！宝宝的食材银行又多了 %@ 个安全食材;\n\n%@ 个新食材出现了过敏症状以及 %@ 个新食材被拒绝，未进入食材银行;",0,@"0",@"0",@"0",@"0"];
    self.zhouzongjie.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
    
    
    [ZDNetwork getZhouCallback:^(RspState *rsp, NSDictionary *rspDict) {
        if(rsp.rspCode == 0){
//            rspDict
            NSArray *array = rspDict[@"foodList"];
            NSInteger arrayCount = array.count;
            
            NSString *string = nil;
            NSString *lastString = @"";
            for (NSString *value in array) {
                if(array.count <=1){
                    string = [NSString stringWithFormat:@"%@%@", lastString, value];
                    lastString = [NSString stringWithFormat:@"%@", string];
                }else{
                    string = [NSString stringWithFormat:@"%@、%@", lastString, value];
                    lastString = [NSString stringWithFormat:@"%@", string];
                }
            }
            
            NSString *anquan = rspDict[@"anquan"];
            NSString *guomin = rspDict[@"guomin"];
            NSString *jujue  = rspDict[@"jujue"];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineHeightMultiple = 10.f;
            paragraphStyle.maximumLineHeight = 20.f;
            paragraphStyle.minimumLineHeight = 20.f;
            paragraphStyle.alignment = NSTextAlignmentJustified;
            
            
            NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(16)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1]
                                                  }mutableCopy];
            NSString *str = [NSString stringWithFormat:@"本周您给宝宝尝试了 %d 个新食材，为：\n\n %@。\n\n恭喜您！宝宝的食材银行又多了 %@ 个安全食材;\n\n%@ 个新食材出现了过敏症状以及 %@ 个新食材被拒绝，未进入食材银行;",arrayCount,lastString,anquan,guomin,jujue];
            self.zhouzongjie.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
            
        }
    }];
    
    
//    20,90
    self.zhouzongjie.userInteractionEnabled = NO;
    

}


@end
