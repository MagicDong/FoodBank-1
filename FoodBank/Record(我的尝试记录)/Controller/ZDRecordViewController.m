 //
//  ZDRecordViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRecordViewController.h"
#import "YGPSegmentedController.h"
#import "AppDelegate.h"
#import "LBorderView.h"
#import <QuartzCore/QuartzCore.h>
#import "ZDAllergyViewController.h"
#import "ZDRejectViewController.h"
#import "ZDPresentViewController.h"
#import "ChoiceButton.h"
#import "MBProgressHUD+ZD.h"
#import "ZDMoreView.h"
#import "ZDTuiJianViewController.h"
#import "ZDNetwork.h"
#import "ZDTryRecord.h"
#import "ZDCategoryCell.h"

@interface ZDRecordViewController ()<ZDMoreViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    YGPSegmentedController * _ygp;
    UILabel * label;
    __weak IBOutlet LBorderView *_borderView1;
}

/** 之前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *anquan;
@property (weak, nonatomic) IBOutlet UIButton *guomin;
@property (weak, nonatomic) IBOutlet UIButton *jujue;
@property (weak, nonatomic) IBOutlet UIButton *weichangshi;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UILabel *babyYue;
@property (weak, nonatomic) IBOutlet UILabel *toDay;
@property (weak, nonatomic) IBOutlet UILabel *zhouqi;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, assign) BOOL isIng;
@property (nonatomic, strong)UIButton *cover;
@property (nonatomic ,weak) ZDMoreView *moreView;
@property (nonatomic,assign) BOOL xiala;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (weak, nonatomic) IBOutlet UIImageView *babyIcon;
@property (nonatomic, assign) NSInteger integer;
@end

static NSString *categoryCellID = @"categoryCell";
@implementation ZDRecordViewController

- (IBAction)present:(UIButton *)sender {
    NSDictionary *foodInfo = @{@"foodName":self.foodName.text,@"zhouqi":self.zhouqi.text,@"toDay":self.toDay.text};
    ZDTuiJianViewController *present = [[ZDTuiJianViewController alloc]init];
    present.foodInfo = foodInfo;
    [self.navigationController pushViewController:present animated:YES];
    
}

- (IBAction)anquan:(UIButton *)sender {
//    // 取消之前选中按钮的选中状态
//    self.selectedButton.selected = NO;
//    // 设置点中按钮的selected ＝ YES
//    sender.selected = YES;
//    // 将当前按钮作为选中按钮
//    self.selectedButton = sender;
    [ZDNetwork postTryResultTryState:@"1" CallBack:^(RspState *rsp) {
        if (rsp.rspCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交尝试结果成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交尝试结果失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (IBAction)guomin:(UIButton *)sender {
//    // 取消之前选中按钮的选中状态
//    self.selectedButton.selected = NO;
//    // 设置点中按钮的selected ＝ YES
//    sender.selected = YES;
//    // 将当前按钮作为选中按钮
//    self.selectedButton = sender;
    ZDAllergyViewController *allergy = [[ZDAllergyViewController alloc]init];
    [self.navigationController pushViewController:allergy animated:YES];
}


- (IBAction)jujue:(UIButton *)sender {
//    // 取消之前选中按钮的选中状态 
//    self.selectedButton.selected = NO;
//    // 设置点中按钮的selected ＝ YES
//    sender.selected = YES;
//    // 将当前按钮作为选中按钮
//    self.selectedButton = sender;
    
    ZDRejectViewController *reject = [[ZDRejectViewController alloc]init];
    [self.navigationController pushViewController:reject animated:YES];
}

- (IBAction)weichangshi:(UIButton *)sender {
//    // 取消之前选中按钮的选中状态
//    self.selectedButton.selected = NO;
//    // 设置点中按钮的selected ＝ YES
//    sender.selected = YES;
//    // 将当前按钮作为选中按钮
//    self.selectedButton = sender;
    
    [ZDNetwork postTryResultTryState:@"4" CallBack:^(RspState *rsp) {
        if (rsp.rspCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交尝试结果成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
int i =0;
- (void)viewDidLoad{
    [super viewDidLoad];
    [ZDNetwork getTryRecordInfoCallback:^(RspState *rsp, NSArray *array) {
        if (rsp.rspCode == 0) {
            self.dataList = array;
        }else{

        }
    }];
    
    [self setupTableView];
    self.title = @"尝试记录";
    
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    for (int i = 1; i<=7; i++) {
        unsigned units=NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
        NSCalendar *mycal=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now=[NSDate date];
        NSDateComponents *comp =[mycal components:units fromDate:now];
        NSInteger month=[comp month];
        NSInteger year =[comp year];
        NSInteger day=[comp day];
        
        NSCalendar *gregorian = [NSCalendar currentCalendar];
        NSDateComponents *dateComps = [gregorian components:NSWeekdayCalendarUnit fromDate:now];
        int daycount = [dateComps weekday] - i;
        NSDate *weekdaybegin = [now addTimeInterval:-daycount*60*60*24];
        NSDate *weekdayend   = [now addTimeInterval:(6-daycount)*60*60*24];
        NSDateFormatter *df1=[[NSDateFormatter alloc]init];
        NSLocale *mylocal=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        [df1 setLocale:mylocal];
        //    [mylocal release];
        [df1 setDateFormat:@"YYYY-MM-d"];
        now=weekdaybegin;
        comp=[mycal components:units fromDate:now];
        month=[comp month];
        year =[comp year];
        day=[comp day];
        NSString *date1=[[NSString alloc]initWithFormat:@"%02d月%02d日",month,day];//所要求的周一的日期
        [arrayM addObject:date1];
    }
    
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithArray:arrayM];
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }

    UINib *categoryNib = [UINib nibWithNibName:@"ZDCategoryCell" bundle:nil];
    [self.tableView registerNib:categoryNib forCellReuseIdentifier:categoryCellID];
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.titleArray = TitielArray;
    [self.tableView reloadData];
    
    self.anquan.layer.cornerRadius = 5;
    self.anquan.layer.masksToBounds = YES;
    self.jujue.layer.cornerRadius = 5;
    self.jujue.layer.masksToBounds = YES;
    self.guomin.layer.cornerRadius = 5;
    self.guomin.layer.masksToBounds = YES;
    self.weichangshi.layer.cornerRadius = 5;
    self.weichangshi.layer.masksToBounds = YES;
    self.babyIcon.layer.cornerRadius = 30;
    self.babyIcon.layer.masksToBounds = YES;
    CALayer *layer = [self.babyIcon layer];
    layer.borderColor = [UIColor colorWithRed:(161)/255.0 green:(255)/255.0 blue:(169)/255.0 alpha:1.0f].CGColor;
    layer.borderWidth = 1.0f;
    
}

- (void)setupTableView{
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *ID = @"share";
    ZDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
    cell.title = self.titleArray[indexPath.row];
    if (indexPath.row == i) {
        cell.zhuangtai = 1;
        cell.selected = YES;
    }else{
        cell.zhuangtai = 0;
        cell.selected = NO;
    }
//    cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:(14)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *p = [NSIndexPath indexPathForItem:i inSection:0];
    
    ZDCategoryCell *deCell =  (ZDCategoryCell *)[tableView cellForRowAtIndexPath:p];
    deCell.selected = NO;
    deCell.zhuangtai = 0;
    
    ZDCategoryCell *cell =  (ZDCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.zhuangtai = 1;
    cell.selected = YES;
    i = indexPath.row;
    // 更新表
//    ZDTryRecord *dict = _dataList[indexPath.row];
//    [self.foodName setText:dict.mname];
//    [self.toDay setText:[NSString stringWithFormat:@"%@",dict.isTrying]];
//    [self.zhouqi setText:[NSString stringWithFormat:@"%@",dict.cycle]];
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    return ((h - 100 - 98)/7);
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    ZDTryRecord *dict = _dataList[0];
    [self.foodName setText:dict.mname];
    [self.toDay setText:[NSString stringWithFormat:@"%@",dict.isTrying]];
    [self.zhouqi setText:[NSString stringWithFormat:@"%@",dict.cycle]];
//    NSLog(@"%d",self.dataList.count);
//    if (_dataList) {
//
//        ZDTryRecord *dict = self.dataList[0];
//        self.foodName.text = dict.mname;
//        self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//        self.zhouqi.text = dict.cycle;
//        ZDLog(@"%@",self.foodName.text);
//        ZDLog(@"%@",self.toDay.text);
//        ZDLog(@"%@",self.zhouqi.text);
//    }
}

//@property (weak, nonatomic) IBOutlet UILabel *foodName;
//@property (weak, nonatomic) IBOutlet UILabel *babyName;
//@property (weak, nonatomic) IBOutlet UILabel *babyYue;
//@property (weak, nonatomic) IBOutlet UILabel *toDay;
//@property (weak, nonatomic) IBOutlet UILabel *zhouqi;
- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    dataList=[{"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-01","introduce":"","isTrying":2,"grams":10,"micon":""},{"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-02","introduce":"","isTrying":1,"grams":10,"micon":""}]
//    {"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-02","introduce":"","isTrying":1,"grams":10,"micon":""}

//    self.foodName.text = dict.mname;
//    self.toDay.text = @"11";
//    ZDTryRecord *dict = self.dataList[0];
//    self.foodName.text = dict.mname;
//    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//    self.zhouqi.text = dict.cycle;
//    ZDLog(@"%@",self.foodName.text);
//    ZDLog(@"%@",self.toDay.text);
//    ZDLog(@"%@",self.zhouqi.text);
}

- (void)more{
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.cover setAlpha:0];
            [self.moreView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
            [self.cover removeFromSuperview];
            self.xiala = NO;
        }];
        return;
    }else{
        // 1.添加按钮蒙板
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = self.view.window.frame;
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
        cover.userInteractionEnabled = YES;
        // 控制UIButton的透明度
        [cover setAlpha: 0.0];
        [self.moreView setAlpha:0];
        self.cover = cover;
        [self.view.window addSubview:cover];
        [self.view.window bringSubviewToFront:self.moreView];
        
        [UIView animateWithDuration:0.5 animations:^{
            // 监听蒙板点击事件
            [self.moreView setAlpha:1];
            [self.cover setAlpha: 0.65];
        } completion:^(BOOL finished) {
            self.xiala = YES;
        }];
        return;
    }
}

- (void)smallImage{
    
}

#pragma mark - 懒加载
- (ZDMoreView *)moreView{
    if (!_moreView) {
        _moreView = [ZDMoreView moreView];
        self.moreView.y = self.moreView.y - self.moreView.height;
        self.moreView.center = self.view.center;
        self.moreView.borderType = BorderTypeDashed;
        self.moreView.dashPattern = 2;
        self.moreView.borderWidth = 1;
        self.moreView.cornerRadius = 10;
        self.moreView.borderColor = [UIColor redColor];
        self.moreView.backgroundColor = ZDColor(255, 246, 229)
        self.moreView.delegate = self;
        [self.view.window  addSubview:_moreView];
    }
    return _moreView;
}

- (void)moreViewDidOK:(ZDMoreView *)moreView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.cover setAlpha:0];
        [self.moreView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.moreView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.xiala = NO;
    }];
}

- (void)moreViewDidWWW:(ZDMoreView *)moreView{
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

}

-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl == _ygp) {
        switch (index) {
            case 0:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[0];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                break;
            case 1:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[1];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                
                break;
            case 2:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[2];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                
                break;
            case 3:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[3];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                break;
            case 4:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[4];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                break;
            case 5:
//                if (_dataList) {
//                    ZDTryRecord *dict = _dataList[5];
//                    self.foodName.text = dict.mname;
//                    self.toDay.text = [[NSString alloc]initWithFormat:@"%d",dict.isTrying];
//                }
                break;
            case 6:
                
                break;
            default:
                break;
        }
    }
}

//- (IBAction)queren:(UIButton *)sender {
//
//    if ([self.selectedButton.titleLabel.text isEqualToString:@"安全"]) {
//        [ZDNetwork postTryResultTryState:@"1" CallBack:^(RspState *rsp) {
//            if (rsp.rspCode == 0) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交尝试结果成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }];
//    }else if ([self.selectedButton.titleLabel.text isEqualToString:@"过敏"]){
//        ZDAllergyViewController *allergy = [[ZDAllergyViewController alloc]init];
//        [self.navigationController pushViewController:allergy animated:YES];
//    }else if ([self.selectedButton.titleLabel.text isEqualToString:@"拒绝"]){
//        ZDRejectViewController *reject = [[ZDRejectViewController alloc]init];
//        [self.navigationController pushViewController:reject animated:YES];
//    }else if([self.selectedButton.titleLabel.text isEqualToString:@"未尝试"]){
//        [ZDNetwork postTryResultTryState:@"4" CallBack:^(RspState *rsp) {
//            if (rsp.rspCode == 0) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交尝试结果成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }];
//    }
//
//    if (self.selectedButton == nil) {
//        [MBProgressHUD showError:@"您还没有选择尝试情况"];
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [MBProgressHUD hideHUD];
//
//    });
//}

@end
