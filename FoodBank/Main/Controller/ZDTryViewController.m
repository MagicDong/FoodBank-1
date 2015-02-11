//
//  ZDPlanViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDTryViewController.h"
#import "ZDTryChooseButton.h"
#import "ZDTuiJianViewController.h"
#import "ZDEditController.h"
#import "ZDMoreView.h"
#import "MBProgressHUD+ZD.h"
#import "ZDNetwork.h"
#import "UIImageView+WebCache.h"
#import "ZDNewFood.h"
#import "UMSocial.h"
#import "UIBarButtonItem+ZD.h"
#import "UIImage+ZD.h"

/** 是否是IOS7以上 */
#define iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

@interface ZDTryViewController () <UITableViewDataSource,UITableViewDelegate,ZDEditDelegate,UMSocialUIDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;   // 食材图片
@property (weak, nonatomic) IBOutlet UIButton *nameEdit;  // 换食材
@property (weak, nonatomic) IBOutlet UILabel *ke;         // 克数
@property (nonatomic, strong) UIImage *downImage;         // 向下图片
@property (nonatomic, strong) UIImage *upImage;           // 向上的图片
@property (nonatomic, strong) UITableView *table;         // 点击按钮出来天数
@property (weak, nonatomic) IBOutlet UITextView *jieshaoTextView;
@property (weak, nonatomic) IBOutlet UITextView *tuijianTextView;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (nonatomic, strong) UIButton *tianBtn;
@property (nonatomic, strong)UIButton *cover;
@property (weak, nonatomic) IBOutlet UIButton *queren;
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@property (nonatomic,copy) NSString *cornerID;
@property (nonatomic,copy) NSString *cornerT;
@property (nonatomic,copy) NSString *cornerTian;
@property (weak, nonatomic) IBOutlet UILabel *zhouqiA;

@end

@implementation ZDTryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque = YES;
    }
    CGFloat x = [UIScreen mainScreen].bounds.size.width;
    ZDTryChooseButton *tianBtn = [[ZDTryChooseButton alloc]initWithFrame:CGRectMake(x - 73, 76, 65, 40)];
    [tianBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [tianBtn setTitle:@"3天" forState:UIControlStateNormal];
    [tianBtn addTarget:self action:@selector(tianBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tianBtn];
    self.tianBtn = tianBtn;
    
    
    // 3.添加更多按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(trying)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 10.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(15)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]
                                  };
    
    self.jieshaoTextView.attributedText = [[NSAttributedString alloc]initWithString:@"食材介绍" attributes:attributes];
    self.jieshaoTextView.editable = NO;
    self.jieshaoTextView.backgroundColor = [UIColor clearColor];
    
    self.tuijianTextView.attributedText = [[NSAttributedString alloc]initWithString:@"暂无介绍" attributes:attributes];
    self.tuijianTextView.editable = NO;
    self.tuijianTextView.backgroundColor = [UIColor clearColor];
    
    
//    [{"mname":"芒果","practice":"","pgtpid":42,"introduce":"","mid":558},{"mname":"干裙带菜(泡发)","practice":"","pgtpid":25,"introduce":"","mid":459}];
    [self getTryFood];
}
- (void)getTryFood{
    [ZDNetwork getTodayTryInfoCallback:^(RspState *rsp, NSArray *array) {
        
        //        [MBProgressHUD hideHUD];
        if (rsp.rspCode == 0) {
            ZDNewFood *food = array[0];
            NSString *iconStr = [NSString stringWithFormat:@"http://192.168.1.250/mimag/%@.png",food.mid];
            NSURL *url = [NSURL URLWithString:iconStr];
            [self.icon sd_setImageWithURL:url];
            self.foodName.text = food.mname;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineHeightMultiple = 20.f;
            paragraphStyle.maximumLineHeight = 25.f;
            paragraphStyle.minimumLineHeight = 10.f;
            paragraphStyle.firstLineHeadIndent = 20.f;
            paragraphStyle.alignment = NSTextAlignmentJustified;
            NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:(15)], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]};
            self.jieshaoTextView.attributedText = [[NSAttributedString alloc]initWithString:food.introduce attributes:attributes];
            self.tuijianTextView.attributedText = [[NSAttributedString alloc]initWithString:food.practice attributes:attributes];
            self.cornerID = food.mid;
        }else{
            
            //            [MBProgressHUD showError:@"网络错误"];
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                [MBProgressHUD hideHUD];
            //            });
            
            return;
        }
    }];
}
- (void)didSelectedMid:(NSDictionary *)mid{
    
    NSLog(@"%@",mid);
    
    NSString *iconStr = [NSString stringWithFormat:@"http://192.168.1.250/mimag/%@.png",mid[@"mid"]];
    NSURL *url = [NSURL URLWithString:iconStr];
    [self.icon sd_setImageWithURL:url];
    self.foodName.text = mid[@"mname"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 10.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]};
//    self.jieshaoTextView.attributedText = [[NSAttributedString alloc]initWithString:mid[@"introduce"] attributes:attributes];
//    self.tuijianTextView.attributedText = [[NSAttributedString alloc]initWithString:mid[@"practice"] attributes:attributes];
    self.cornerID = mid[@"mid"];
    
//    NSString *iconStr = [NSString stringWithFormat:@"http://192.168.1.250/mimag/%@.png",foodDict[@"mid"]];
//    NSURL *url = [NSURL URLWithString:iconStr];
//    [self.iconView sd_setImageWithURL:url];
//    self.title.text = foodDict[@"mname"];
//    self.mid = foodDict[@"mid"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //    [MBProgressHUD showError:@"获取尝试信息中..."];

}


- (void)more{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5417d98ffd98c5661607aed9"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToDouban,UMShareToSms,nil]
                                       delegate:self];
    
//    610185387
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
//    [self.view.window bringSubviewToFront:self.moreView];
//    if (self.xiala) {
//        [UIView animateWithDuration:0.5 animations:^{
//            //            self.moreView.y = self.moreView.y - self.moreView.height;
//            [self.cover setAlpha:0];
//            [self.moreView setAlpha:0];
//        } completion:^(BOOL finished) {
//            [self.moreView removeFromSuperview];
//            [self.cover removeFromSuperview];
//            
//            self.xiala = NO;
//        }];
//        return;
//    }else{
//        // 1.添加按钮蒙板
//        UIButton *cover = [[UIButton alloc] init];
//        cover.frame = self.view.window.frame;
//        cover.backgroundColor = [UIColor blackColor];
//        [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
//        cover.userInteractionEnabled = YES;
//        // 控制UIButton的透明度
//        [cover setAlpha: 0.0];
//        [self.moreView setAlpha:0];
//        self.cover = cover;
//        [self.view.window addSubview:cover];
//        [self.view.window bringSubviewToFront:self.moreView];
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.moreView setAlpha:1];
//            [self.cover setAlpha: 0.65];
//            // 监听蒙板点击事件
//        } completion:^(BOOL finished) {
//            self.xiala = YES;
//        }];
//        return;
//    }
    
}

- (void)smallImage{
    
}

//#pragma mark - 懒加载
//- (ZDMoreView *)moreView{
//    if (!_moreView) {
//        _moreView = [ZDMoreView moreView];
//        self.moreView.y = self.moreView.y - self.moreView.height;
//        self.moreView.center = self.view.center;
//        self.moreView.borderType = BorderTypeDashed;
//        self.moreView.dashPattern = 2;
//        self.moreView.borderWidth = 1;
//        self.moreView.cornerRadius = 10;
//        self.moreView.borderColor = [UIColor redColor];
//        self.moreView.backgroundColor = ZDColor(255, 246, 229)
//        self.moreView.delegate = self;
//        [self.view.window  addSubview:_moreView];
//    }
//    return _moreView;
//}
//
//- (void)moreViewDidOK:(ZDMoreView *)moreView{
//    [UIView animateWithDuration:0.5 animations:^{
//        [self.cover setAlpha:0];
//        [self.moreView setAlpha:0];
//    } completion:^(BOOL finished) {
//        [self.moreView removeFromSuperview];
//        [self.cover removeFromSuperview];
//        self.xiala = NO;
//    }];
//}
//
//- (void)moreViewDidWWW:(ZDMoreView *)moreView{
//    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
//    [[UIApplication sharedApplication] openURL:url];
//}


// 修改尝试周期按钮
- (void)tianBtnOnClick:(ZDTryChooseButton *)try{
    // 1.取出按钮中的图片判断当前的图片是向上还是向下
    if (try.currentImage == self.downImage ) {
        // 向下 --> 向上
        [try setImage:self.upImage forState:UIControlStateNormal];
        UITableView *tian = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.tianBtn.frame) -5, CGRectGetMaxY(try.frame), 72, 150) style:UITableViewStylePlain];
        [self.view addSubview:tian];
        tian.alpha= 0;
        tian.delegate = self;
        tian.dataSource = self;
        self.table = tian;
        [UIView animateWithDuration:0.5f animations:^{
            tian.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        // 向上 --> 向下
        [try setImage:self.downImage forState:UIControlStateNormal];
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"7天";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"6天";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"5天";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"4天";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"3天";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [self.tianBtn setTitle:@"7天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.cornerTian = @"7";
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==1) {
        [self.tianBtn setTitle:@"6天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.cornerTian = @"6";
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==2) {
        [self.tianBtn setTitle:@"5天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.cornerTian = @"5";
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==3) {
        [self.tianBtn setTitle:@"4天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.cornerTian = @"4";
        self.table.alpha = 1;
        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }else if (indexPath.row ==4) {
        [self.tianBtn setTitle:@"3天" forState:UIControlStateNormal];
        [self.tianBtn setImage:self.downImage forState:UIControlStateNormal];
        self.cornerTian = @"3";
        self.table.alpha = 1;

        [UIView animateWithDuration:0.5f animations:^{
            self.table.alpha = 0;
        } completion:^(BOOL finished) {
            [self.table removeFromSuperview];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (IBAction)name:(id)sender {
    ZDEditController *edit = [[ZDEditController alloc]init];
    edit.delegate = self;
    [self.navigationController  pushViewController:edit animated:YES];
}

- (void)trying{
    if (self.cornerTian == nil) {
        self.cornerTian = @"3";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认要提交尝试新食材吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
            
        case 1:
            [MBProgressHUD showMessage:@"提交尝试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.62 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.cornerID) {
                    [ZDNetwork postToDayTryFoodSta:@"1" mid:self.cornerID cycle:self.cornerTian grams:@"5" Callback:^(RspState *rsp) {
                        if (rsp.rspCode == 0) {
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showMessage:@"提交成功！"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.46 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });
                        }else{
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showError:@"该食材正在尝试中!"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.68 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });
                            return;
                        }
                    }];
                }
            });
            break;
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
@end
