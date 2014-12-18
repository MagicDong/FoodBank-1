//
//  ZDMoreView.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-17.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDFoodPickerView.h"
#import "LFCityPickerView.h"

@interface ZDFoodPickerView ()<LFCityPickerViewDelegate>

@property (weak, nonatomic) IBOutlet LFCityPickerView *foodPickView;
@property (weak, nonatomic) IBOutlet UILabel *selectFood;
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UIButton *isOK;

@end
@implementation ZDFoodPickerView

+ (instancetype)foodPickerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDFoodPickerView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.foodPickView.cityDelegate =self ;
    self.isOK.layer.cornerRadius = 10;
    self.isOK.layer.masksToBounds = YES;
}

- (IBAction)isOK:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(moreViewDidOK:)]) {
        // 传递上一次选中的按钮的tag, 和当前选中按钮的tag
//        [self.delegate moreViewDidOK:self.dict];
        [self.delegate foodPicker:self.dict];
    }
}

- (void)cityPickerViewDidSelectedCityName:(NSDictionary *)name{
    self.dict = name;
    self.selectFood.text = name[@"food_name"];
    
}


@end
