//
//  ZDHeaderView.m
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDMoreHeaderView.h"
#import "UIImageView+WebCache.h"
#import "ZDAccount.h"
#import "ZDAccountTool.h"
#import "ZDBabyTool.h"
#import "ZDBaby.h"

@interface ZDMoreHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userSign;

@property (nonatomic,strong) ZDAccount *account;
@property (weak, nonatomic) IBOutlet UIButton *xiugai;

@end
@implementation ZDMoreHeaderView

+ (instancetype)moreHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZDMoreHeaderView" owner:nil options:nil][0];
}

- (IBAction)xiugai:(id)sender {
    BOOL isLogin = (self.account.nickname !=nil);
    isLogin = YES;
    if ([self.headerDelegate respondsToSelector:@selector(didClickHeaderView:)]) {
        [self.headerDelegate didClickHeaderView:isLogin];
    }
}

- (void)awakeFromNib{
    self.userIcon.layer.cornerRadius = 30;
    self.userIcon.layer.masksToBounds = YES;
//    [self.userIcon.layer setBorderWidth:1.5f];
//    
//    CGFloat r = (CGFloat) 0/255.0;
//    CGFloat g = (CGFloat) 0/255.0;
//    CGFloat b = (CGFloat) 0/255.0;
//    CGFloat a = (CGFloat) 0;
//    CGFloat components[4] = {r,g,b,a};
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGColorRef color = (__bridge CGColorRef)(id)CFBridgingRelease(CGColorCreate(colorSpace, components));
//    CGColorSpaceRelease(colorSpace);
//    [self.userIcon.layer setBorderColor:color];
//
    CALayer *layer = [self.userIcon layer];
    layer.borderColor = [UIColor colorWithRed:(161)/255.0 green:(255)/255.0 blue:(169)/255.0 alpha:1.0f].CGColor;
    layer.borderWidth = 1.0f;
    
    self.xiugai.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:0.3];
    [self.xiugai.layer setCornerRadius:10];
    [self.xiugai setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
    self.userIcon.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.userIcon addGestureRecognizer:singleTap];
    
    ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
    if (baby.userIcon != nil) {
         self.userIcon.image = baby.userIcon;
    }
    if ([baby.nickName isEqualToString:@"请输入昵称"]) {
        [self.xiugai setTitle:baby.nickName forState:UIControlStateNormal];
    }else{
        
    }
    if ([baby.signature isEqualToString:@"""这个宝宝很聪明什么也没留下..."""]) {
        self.userSign.text = baby.signature;
    }
}

- (void)onClickImage{
    BOOL isLogin = (self.account.nickname !=nil);
    isLogin = YES;
    if ([self.headerDelegate respondsToSelector:@selector(didClickHeaderView:)]) {
        [self.headerDelegate didClickHeaderView:isLogin];
    }
}



@end
