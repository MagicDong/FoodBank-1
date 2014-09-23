//
//  MBProgressHUD+ZD.h
//
//  Created by Dong on 14-9-22.
//  Copyright (c) 2014年 jiexian. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZD)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
