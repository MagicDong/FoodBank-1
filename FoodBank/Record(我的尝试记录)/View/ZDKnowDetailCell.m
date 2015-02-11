//
//  ZDKnowDetailCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowDetailCell.h"
#import "ZDKnowModel.h"
#import "LBorderView.h"
#import "HBVLinkedTextView.h"
#import "UIColor+HBVHarmonies.h"
@interface ZDKnowDetailCell ()
@property (strong, nonatomic) HBVLinkedTextView *textView;
//@property (weak, nonatomic) IBOutlet LBorderView *borderView;
@end
@implementation ZDKnowDetailCell

+ (instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"detail";
    ZDKnowDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDKnowDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

//- (void)viewDidAppear:(BOOL)animated{
//    self.borderView.borderType = BorderTypeDas                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     hed;
//    self.borderView.dashPattern = 2;
//    self.borderView.spacePattern = 2;
//    self.borderView.borderWidth = 1;
//    self.borderView.cornerRadius = 10;
//    self.borderView.borderColor = [UIColor redColor];
//    self.borderView.backgroundColor = ZDColor(255, 246, 229);
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.userInteractionEnabled = NO;
//        [UIScreen mainScreen].
        /** 是否为4.7英寸屏 */
//    #define Inch47 ([UIScreen mainScreen].bounds.size.height >= 667.0)
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        HBVLinkedTextView *textView = [[HBVLinkedTextView alloc]initWithFrame:CGRectMake(10, 10, w - 20, 170)];
        [self addSubview:textView];
        self.textView = textView;
        
    }
    return self;
}

- (void)setModel:(ZDKnowModel *)model
{
    _model = model;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableDictionary *attributes = [@{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(15)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:153/255. green:102/255. blue:51/255. alpha:1]
                                          }mutableCopy];
    self.textView.attributedText = [[NSAttributedString alloc]initWithString:self.model.detail attributes:attributes];
//    self.textView.backgroundColor = ZDColor(255, 246, 229);
    
//    if (model.open) {
//        self.userInteractionEnabled = NO;
//
//    }else{
//        self.userInteractionEnabled = YES;
//    }
    
}
- (void)awakeFromNib {
    
}

@end
