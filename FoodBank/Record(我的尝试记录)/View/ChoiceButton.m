//
//  IVTButton.m
//  Demod
//
//  Created by ivt bqfj on 14-9-24.
//  Copyright (c) 2014年 ivt bqfj. All rights reserved.
//

#import "ChoiceButton.h"

@implementation ChoiceButton

- (void)awakeFromNib
{
    [self setImage:[UIImage imageNamed:@"radiobox-green-unchecked"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"radiobox-green-checked"] forState:UIControlStateSelected];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat ImageX = 0;
    CGFloat ImageY = 0;
    CGFloat ImageW = self.width * 0.25;
    CGFloat ImageH = self.height;
    return CGRectMake(ImageX, ImageY, ImageW, ImageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat TitleX = CGRectGetMaxX(self.imageView.frame) + 5;
    CGFloat TitleY = 0;
    CGFloat TitleW = self.width - TitleX;
    CGFloat TitleH = self.height;
    return CGRectMake(TitleX, TitleY, TitleW, TitleH);
}

@end
