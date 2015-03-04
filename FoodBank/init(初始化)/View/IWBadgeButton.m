//
//  IWBadgeButton.m
//  传智微博
//
//  Created by apple on 14-7-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBadgeButton.h"

@implementation IWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizableImageNamed:@"yuanxin"] forState:UIControlStateNormal];
//        self.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:(10)];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
//        UIColor *color = [UIColor colorWithRed:53.0f green:160.0f blue:57.0f alpha:1.0f];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.size = self.currentBackgroundImage.size;
        self.hidden = YES;
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
//    NSLog(@"====%@",badgeValue);
    if (badgeValue.intValue) {
        // 有未读消息
//        self.hidden = NO;
        
        NSString *value = nil;
        if (badgeValue.intValue >= 100) {
            
            value = @"N";
        }else
        {
            value = badgeValue;
        }
        [self setTitle:value forState:UIControlStateNormal];
        
    }else
    {
        self.hidden = YES;
    }
}

@end
