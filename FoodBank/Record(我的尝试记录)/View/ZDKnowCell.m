//
//  ZDKnowCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowCell.h"
#import "ZDKnowModel.h"
#import "ZDKnowTableViewController.h"

@interface ZDKnowCell () <ZDKnowDelegate>
/**
 *  向下的图片
 */
@property (nonatomic, strong) UIImage *downImage;
/**
 *  向上的图片
 */
@property (nonatomic, strong) UIImage *upImage;

@end
@implementation ZDKnowCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"share";
    ZDKnowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDKnowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.userInteractionEnabled = YES;
        self.accessoryView = [[UIImageView alloc] initWithImage:self.upImage];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.backgroundColor = ZDColor(255, 246, 229);
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.textLabel.textColor = ZDColor(53, 158, 58);
    }
    return self;
}

- (void)cellClick:(UIImageView *)imageView
{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (imageView.image == self.downImage) {
        
//        // 向下 --> 向上
//        _foodPickerView = [ZDFoodPickerView foodPickerView];
//        _foodPickerView.y = self.view.height;
//        // 设置代理
//        _foodPickerView.delegate = self;
//        [self.view addSubview:_foodPickerView];
//        
//        [titleBtn setImage:self.upImage forState:UIControlStateNormal];
//        self.foodPickerView.y = self.view.height;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.foodPickerView.y = self.view.height - self.foodPickerView.height;
//        } completion:^(BOOL finished) {
//            
//        }];
        
    }else
    {
//        // 向上 --> 向下
//        [titleBtn setImage:self.downImage forState:UIControlStateNormal];
//        self.foodPickerView.y = self.view.height - self.foodPickerView.height;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.foodPickerView.y = self.view.height;
//        } completion:^(BOOL finished) {
//            [self.foodPickerView removeFromSuperview];
//        }];
    }
}

- (void)setIsOpen:(NSInteger)isOpen{
    _isOpen = isOpen;
//    if ((self.accessoryView = [[UIImageView alloc] initWithImage:self.upImage])) {
//        self.accessoryView = [[UIImageView alloc] initWithImage:self.downImage];
//    }else{
//        self.accessoryView = [[UIImageView alloc] initWithImage:self.upImage];
//    }
    if (isOpen) {
        self.accessoryView = [[UIImageView alloc] initWithImage:self.upImage];
    }else{
        self.accessoryView = [[UIImageView alloc] initWithImage:self.downImage];
    }
}

- (UIImage *)downImage
{
    if (!_downImage) {
        _downImage = [UIImage imageWithNamed:@"navigationbar_arrow_down"];
    }
    return _downImage;
}

- (UIImage *)upImage
{
    if (!_upImage) {
        _upImage = [UIImage imageWithNamed:@"navigationbar_arrow_up"];
    }
    return _upImage;
}

- (void)setDict:(NSString *)dict{
    _dict = dict;
    self.textLabel.text = dict;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    self.textLabel.text =  [NSString stringWithFormat:@"%d、%@",row,self.textLabel.text];
}

@end
