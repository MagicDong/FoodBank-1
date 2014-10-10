//
//  ZDZhouViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDZhouViewController.h"
#import "ZDBankBtn.h"

@interface ZDZhouViewController ()
@property (weak, nonatomic) IBOutlet ZDBankBtn *s1;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s2;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s3;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s4;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s5;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s6;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s7;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s8;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s9;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s10;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s11;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s12;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s13;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s14;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s15;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s16;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s17;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s18;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s19;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s20;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s21;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s22;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s23;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s24;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s25;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s26;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s27;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s28;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s29;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s30;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s31;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s32;
@property (weak, nonatomic) IBOutlet ZDBankBtn *s33;

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
    self.s1.layer.borderWidth = 1.0f;
    self.s1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s2.layer.borderWidth = 1.0f;
    self.s2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s3.layer.borderWidth = 1.0f;
    self.s3.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s4.layer.borderWidth = 1.0f;
    self.s4.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s5.layer.borderWidth = 1.0f;
    self.s5.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s6.layer.borderWidth = 1.0f;
    self.s6.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s7.layer.borderWidth = 1.0f;
    self.s7.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s8.layer.borderWidth = 1.0f;
    self.s8.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s9.layer.borderWidth = 1.0f;
    self.s9.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s10.layer.borderWidth = 1.0f;
    self.s10.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s11.layer.borderWidth = 1.0f;
    self.s11.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s12.layer.borderWidth = 1.0f;
    self.s12.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s13.layer.borderWidth = 1.0f;
    self.s13.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s14.layer.borderWidth = 1.0f;
    self.s14.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s15.layer.borderWidth = 1.0f;
    self.s15.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s16.layer.borderWidth = 1.0f;
    self.s16.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s17.layer.borderWidth = 1.0f;
    self.s17.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s18.layer.borderWidth = 1.0f;
    self.s18.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s19.layer.borderWidth = 1.0f;
    self.s19.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s20.layer.borderWidth = 1.0f;
    self.s20.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s21.layer.borderWidth = 1.0f;
    self.s21.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s22.layer.borderWidth = 1.0f;
    self.s22.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s23.layer.borderWidth = 1.0f;
    self.s23.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s24.layer.borderWidth = 1.0f;
    self.s24.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s25.layer.borderWidth = 1.0f;
    self.s25.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s26.layer.borderWidth = 1.0f;
    self.s26.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s27.layer.borderWidth = 1.0f;
    self.s27.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s28.layer.borderWidth = 1.0f;
    self.s28.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s29.layer.borderWidth = 1.0f;
    self.s29.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s30.layer.borderWidth = 1.0f;
    self.s30.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s31.layer.borderWidth = 1.0f;
    self.s31.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s32.layer.borderWidth = 1.0f;
    self.s32.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.s33.layer.borderWidth = 1.0f;
    self.s33.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

@end
