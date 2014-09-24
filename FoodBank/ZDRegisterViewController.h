//
//  RegisterViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-18.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface ZDRegisterViewController : UIViewController<TencentSessionDelegate>
{
    TencentOAuth * _tencentOAuth;
    NSMutableArray* _permissions;
    UILabel                *_labelTitle;
    UILabel                *_labelAccessToken;
}

@end

                                                 