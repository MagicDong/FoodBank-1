//
//  ZDNationView.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-26.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ZDNationView : UIView

@class ZDNationView;

@protocol ZDNationViewDelegate <NSObject>

- (void)nationView:(ZDNationView *)picker dateStr:(NSString *)dateStr;

@end

@interface ZDNationView : UIView

+ (instancetype)nationView;

@property (nonatomic, weak) id <ZDNationViewDelegate> delegate;


@end
