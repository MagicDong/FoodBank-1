//
//  ZDBabyInfoTableViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-29.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDBabyInfoTableViewController.h"
#import "ZDAccount.h"
#import "ZDAccountTool.h"
#import "CZDatePickerView.h"
#import "ZDBaseCell.h"
#import "ZDLoginIconCell.h"
#import "ZDLoginSignCell.h"
#import "ZDLoginNickCell.h"
#import "ZDLoginSexCell.h"
#import "ZDLoginCitysCell.h"
#import "ZDLoginBirthdayCell.h"
#import "ZDLoginInfoModel.h"
#import "ZDSingView.h"
#import "MBProgressHUD+ZD.h"
#import "ZDEditAlter.h"
#import "TSLocateView.h"
#import "ZDBabyTool.h"
#import "ZDBaby.h"

static NSString *iconCellID = @"iconCell";
static NSString *signCellID = @"signCell";
static NSString *nickCellID = @"nickCell";
static NSString *sexCellID = @"sexCell";
static NSString *citysCellID = @"citysCell";
static NSString *birthdayCellID = @"birthdayCell";
@interface ZDBabyInfoTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate,UIAlertViewDelegate,CZDatePickerViewDelegate,UIActionSheetDelegate>
/**
 *  时间选择
 */
@property (nonatomic ,weak) CZDatePickerView *datePickerView;
/**
 *  选择城市
 */
@property (nonatomic ,strong) TSLocateView *locateView ;
@property (nonatomic ,strong) NSMutableArray *infoModel;
@property (nonatomic ,strong) ZDLoginIconCell *iconCell;
@property (nonatomic ,strong) ZDLoginBirthdayCell *birthdayCell;
@property (nonatomic ,strong) ZDLoginCitysCell *citysCell;
@property (nonatomic ,strong) ZDLoginNickCell *nickCell;
@property (nonatomic ,strong) ZDLoginSexCell *sexCell;
@property (nonatomic ,strong) ZDLoginSignCell *signCell;

@end

@implementation ZDBabyInfoTableViewController

-(id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - UIAlterDelegate
- (void)alertView:(ZDEditAlter *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        if (alertView.tag == 0 ) {
//            self.signCell.sign.text = alertView.textField.text;
//            ZDLog(@"签名%@",alertView.textField.text);
        }else if(alertView.tag == 1){
            ZDLog(@"昵称%@",alertView.textField.text);
        }else if (alertView.tag == 3){
            
        }
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            
        }
    }else if (alertView.tag == 3){
        if (buttonIndex == 0) {// 保存按钮点击确定
            ZDBaby *baby = [ZDBabyTool sharedZDBabyTool].account;
            ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
            baby.userIcon = self.iconCell.userIcon.image;
            baby.signature = self.signCell.sign.text;
            baby.nickName = self.nickCell.nickName.text;
            baby.city = self.citysCell.citys.text;
            baby.birthday = self.birthdayCell.birthday.text;
            baby.sex = self.sexCell.isNan;
            BOOL isOK = [babyTool saveAccount:baby];
            ZDLog(@"%@",baby.signature);
            if (isOK) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            //  baby.sex = self.sexCell;
            //  @property (nonatomic ,strong) ZDLoginIconCell *iconCell;
            //  @property (nonatomic ,strong) ZDLoginBirthdayCell *birthdayCell;
            //            @property (nonatomic ,strong) ZDLoginCitysCell *citysCell;
            //            @property (nonatomic ,strong) ZDLoginNickCell *nickCell;
            //            @property (nonatomic ,strong) ZDLoginSexCell *sexCell;
            //            @property (nonatomic ,strong) ZDLoginSignCell *signCell;
        }else if (buttonIndex ==1){// 保存按钮点击取消
            
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"宝贝个人信息";
    self.tableView.userInteractionEnabled = YES;
    //注册nibs
    [self regCellNibs];
    //注册通知中心
    //    [self regNotification];
//    if(iOS7)
//    {
//        self.edgesForExtendedLayout = NO;
//        self.navigationController.navigationBar.opaque=YES;
//    }
//
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(btnSave:)];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"保存"];
    self.navigationItem.rightBarButtonItem = btn;
//    [btn initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(btnSave:)];
}

- (void)btnSave:(UIBarButtonItem *)button{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存" message:@"确定保存当前修改内容？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 3;
    [alert show];
}

/**
 *  注册通知中心
 */
- (void)regNotification
{
    //头像通知响应
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPicture) name:@"ZDLoginIcon" object:nil];
    //个人签名通知响应
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signView) name:@"ZDLoginSignCell" object:nil];
    //昵称通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickView) name:@"ZDLoginNickCell" object:nil];
}

- (void)dealloc
{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 注册NIB
/**
 *  注册NIB
 */
- (void)regCellNibs
{
    //注册icon NIB
    UINib *iconNib = [UINib nibWithNibName:@"ZDLoginIconCell" bundle:nil];
    [self.tableView registerNib:iconNib forCellReuseIdentifier:iconCellID];
    //注册sign NIB
    UINib *signNib = [UINib nibWithNibName:@"ZDLoginSignCell" bundle:nil];
    [self.tableView registerNib:signNib forCellReuseIdentifier:signCellID];
    //注册nick NIB
    UINib *nickNib = [UINib nibWithNibName:@"ZDLoginNickCell" bundle:nil];
    [self.tableView registerNib:nickNib forCellReuseIdentifier:nickCellID];
    //注册sex NIB］
    UINib *sexNib = [UINib nibWithNibName:@"ZDLoginSexCell" bundle:nil];
    [self.tableView registerNib:sexNib forCellReuseIdentifier:sexCellID];
    //注册citys NIB
    UINib *citysNib = [UINib nibWithNibName:@"ZDLoginCitysCell" bundle:nil];
    [self.tableView registerNib:citysNib forCellReuseIdentifier:citysCellID];
    //注册birthday NIB
    UINib *birthdayNib = [UINib nibWithNibName:@"ZDLoginBirthdayCell" bundle:nil];
    [self.tableView registerNib:birthdayNib forCellReuseIdentifier:birthdayCellID];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }else{
        return 1;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDBaseCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:iconCellID];
        self.iconCell = (ZDLoginIconCell *)cell;
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:signCellID];
        self.signCell = (ZDLoginSignCell *)cell;
    }else if(indexPath.section == 2 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:nickCellID];
        self.nickCell = (ZDLoginNickCell *)cell;
    }else if(indexPath.section == 2 && indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:sexCellID];
        self.sexCell = (ZDLoginSexCell *)cell;
    }else if(indexPath.section == 2 && indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:citysCellID];
        self.citysCell = (ZDLoginCitysCell *)cell;
    }else if(indexPath.section == 2 && indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:birthdayCellID];
        self.birthdayCell = (ZDLoginBirthdayCell *)cell;
    }
    cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:(13)];
    cell.contentView.userInteractionEnabled = YES;
    //    cell.info = self.infoModel[indexPath.row];
    return cell;
    //    UIInputViewController
}

//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [ZDLoginIconCell rowHeight];
    }else if (indexPath.section == 1){
        return [ZDLoginSignCell rowHeight];
    }else return [ZDBaseCell rowHeight];
}

//设置头尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 10;
}
/**
 *  设置headertitle
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (1 == section) {
        return @"个性签名";
    }else if(2 == section){
        return @"基础信息";
    }else return nil;
    
}
/**
 *  cell点击响应
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //头像修改
        [self openPicture];
    }else if (indexPath.section == 1){
        //输入签名
        [self signView:0];
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                //修改昵称
                [self nickView:1];
                break;
            case 1:
                //修改性别
//                [self sexView:2];
                break;
            case 2:
                //修改城市
                [self citysView];
                break;
            case 3:
                //修改生日
                [self dateView];
                break;
            default:
                break;
        }
    }
}

/**
 *  头像修改方法
 */
- (void)openPicture
{
    //    ZDLog(@"ZDLoginIcon");
    // 1.创建相册控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 设置数据源
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 设置代理, 监听用户选中的相片
    picker.delegate = self;
    // 2.弹出相册
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  用户选中相片之后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    ZDLog(@"info = %@", info);
    // 1.关闭相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.取出用户选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.iconCell.userIcon.image = image;
    
}



/**
 *  签名实现方法
 */
- (void)signView:(NSInteger )tag
{
    //    ZDLog(@"singView");
    ////    UINavigationController *vc = [[UINavigationController alloc]init];
    //    ZDSingView *signView = [[ZDSingView alloc]init];
    ////    [vc addChildViewController:signView];
    //    signView.delegate = self;
    //    [self presentViewController:signView animated:YES completion:nil];
    ZDEditAlter *alter = [[ZDEditAlter alloc]initWithTitle:@"签名" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alter.tag = tag;
    [alter show];
}

/**
 *  昵称实现方法
 */
- (void)nickView:(NSInteger )tag
{
    ZDEditAlter *alter = [[ZDEditAlter alloc]initWithTitle:@"昵称" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alter.tag = tag;
    
    [alter show];
}
///**
// *  性别选择框
// */
//- (void)sexView:(NSInteger )tag
//{
//    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message: nil delegate:self cancelButtonTitle:@"男" otherButtonTitles:@"女", nil];
//    alter.tag = tag;
//    
//    [alter show];
//}



/**
 *  城市选择
 */
- (void)citysView
{
    
    [self.locateView showInView:self.view];
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    self.locateView = (TSLocateView *)actionSheet;
    TSLocation *location = self.locateView.locate;
    //You can uses location to your application.
    if(buttonIndex == 0) {
        ZDLog(@"Cancel");
    }else {
        NSString *city = [NSString stringWithFormat:@"%@ %@",location.state,location.city];
        
        //        ZDLog(@"Select city:%@ %@",location.state,location.city);
        ZDLog(@"city %@",city);
    }
}

/**
 *  时间选择
 */
- (void)dateView
{
    self.datePickerView.hidden = NO;
}

#pragma mark - CZDatePickerViewDelegate
//设置生日时间
- (void)datePickerView:(CZDatePickerView *)picker dateStr:(NSString *)dateStr
{
    picker.hidden = YES;
    ZDLog(@"%@",dateStr);
}

#pragma mark - 懒加载
- (CZDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [CZDatePickerView datePickerView];
        _datePickerView.y = self.view.height - _datePickerView.height;
        // 设置代理
        _datePickerView.delegate = self;
        [self.view addSubview:_datePickerView];
    }
    return _datePickerView;
}

- (TSLocateView *)locateView
{
    if (!_locateView) {
        _locateView = [[TSLocateView alloc]initWithTitle:@"选择你所在城市" delegate:self];
        _locateView.y = self.view.height - _locateView.height;
//        _locateView.center = self.view.center;
        
    }
    return _locateView;
}


//#pragma mark -ZDSingViewDelegate
//- (void)signView:(ZDSingView *)singView DoneWithText:(NSString *)text
//{
//#warning 取出签名文本
//    [singView dismissViewControllerAnimated:YES completion:nil];
//    ZDLog(@"----%@---",text);
//}
//
//- (ZDLoginInfoModel *)infoModel
//{
//    if (!_infoModel) {
//        _infoModel = [ZDLoginInfoModel infoData];
//    }
//    return _infoModel;
//}


@end
