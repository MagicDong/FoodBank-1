//
//  ZDMoreView.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-17.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDMoreView.h"

@implementation ZDMoreView

+ (instancetype)moreView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDMoreView" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib{
    
}
- (IBAction)isOK:(UIButton *)sender {
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(moreViewDidOK:)]) {
        // 传递上一次选中的按钮的tag, 和当前选中按钮的tag
        [self.delegate moreViewDidOK:self];
//        [self.delegate tabBar:self didSelectFrom:self.selectedBtn.tag to:btn.tag];
    }
}
- (IBAction)www:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(moreViewDidOK:)]) {
        [self.delegate moreViewDidWWW:self];
    }
}


@end
